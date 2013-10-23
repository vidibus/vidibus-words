# encoding: utf-8
require 'spec_helper'

describe 'Vidibus::Words' do
  describe 'initialization' do
    it 'should require an input string' do
      expect {Vidibus::Words.new}.to raise_error(ArgumentError)
    end

    it 'should accept nil and convert it to an empty string' do
      words = Vidibus::Words.new(nil)
      words.input.should eq('')
    end

    it 'should accept an additional argument to set locales' do
      words = Vidibus::Words.new('hello', :en)
      words.locales.should eql([:en])
    end

    it 'should accept an additional list of locales' do
      words = Vidibus::Words.new('hello', [:en, :de])
      words.locales.should eql([:en, :de])
    end
  end

  describe 'to_a' do
    it 'should call Vidibus::Words.words with input string' do
      stub(Vidibus::Words.words('Whazzup?'))
      Vidibus::Words.new('Whazzup?').to_a
    end
  end

  describe 'sort' do
    it 'should call Vidibus::Words.sort_by_occurrence with list' do
      words = Vidibus::Words.new('Whazzup?')
      stub(Vidibus::Words.sort_by_occurrence(words.list))
      words.sort
    end
  end

  describe 'keywords' do
    let(:input) do
      'El profesor de ajedrez puso fin a la discusión de sus alumnos:
      -Hoy, lo más importante, es la concentración. Deberán abstraerse del entorno y sólo prestar atención al juego. ¡No se olviden que la semana que viene es la maratón de ajedrez en Buenos Aires y ustedes representarán al club!
      -¡Pero, maestro…! No se puede jugar en el bar que está lleno de gente y menos con el loquito de Aníbal al lado.
      -¡Más respeto, jovencito! Aníbal es el hijo del presidente y fanático del ajedrez. Además, hace tiempo que quiere presenciar una partida, de modo que le prometí a su padre que estaría presente en el entrenamiento. ¡Y a ustedes les vendrá muy bien para ensayar la concentración! Los espero esta tarde a las cinco –dijo dando media vuelta y por finalizados los cuestionamientos.
      El bar del club El Alfil, a las cinco de la tarde, estaba muy concurrido por los socios que se reponían de las distintas actividades del día. La mesa dispuesta para el partido estaba instalada en una esquina del salón, un poco aislada de las otras, ocupadas por parroquianos que poca atención le prestaban a los novatos ajedrecistas. En una silla contigua, se sentaba un joven de expresión entusiasta que contrastaba con el semblante adusto de los jugadores. El profesor colocó el reloj sobre la mesa y dio por iniciada la partida. Diego, que jugaba con las blancas, abrió con la apertura Ruy López y detuvo su cronómetro. Enseguida se escuchó el grito de Aníbal:
      -¡Gambito de dama! ¡Gambito de dama!
      Marcelo le echó una mirada de reojo y respondió con la defensa berlinesa para las negras.
      -¡Defensa siciliana! ¡Defensa Siciliana! –chilló Aníbal en el colmo de su exaltación.
      Acodado en la barra, don Antonio observaba la escena y le traducía al Sordo su interpretación de los hechos:
      -Parece que los pibes están jugando a las damas y el loquito de Aníbal les da instrucciones. Por la cara que tienen no les gustan mucho los consejos, pero siendo un juego de damas parece acertado eso de las gambas. Y las sicilianas… ¡Se las traen!
      El Sordo, que además de escuchar poco veía menos, asintió con un movimiento de cabeza.
      En la mesa, los ajedrecistas se esforzaban por no perderse entre los desvaríos de Aníbal y movían sus piezas y detenían sus cronómetros y los volvían a poner en marcha.
      El profesor afirmaba con la testa convencido de que la ordalía les aseguraría el primer puesto en el torneo.
      -¡Defensa india de dama! ¡Defensa india de dama! –vociferó el hijo del presidente desde la silla, obedeciendo la orden de su papá de no moverse.
      -¡Ahora pide que venga una india a defender a la dama! Al fin de cuentas parece que no está tan loquito este Aníbal –le dijo don Antonio en la oreja al Sordo y después se empinó un trago de grapa.
      Los jugadores, estimulados por el acoso del loco, no tardaban más de quince minutos en mover sus piezas. De un solo movimiento, Diego le comió dos peones a Marcelo.
      -¡Peones muertos! ¡Peones muertos! –sollozó Aníbal que era muy sensible.
      -¡Las mujeres son vengativas, Sordo! ¿Qué necesidad de matar a esos pobres laburantes si con despedirlos hubiera protegido a la dama? –Le tironea de la manga de la camisa mientras le dice en voz alta:- ¡Mirá, mirá! ¿No te dije? ¡Es un juego violento!
      En el salón, los aspirantes a campeones perseguían al loquito entre las mesas bombardeándolo con peones, alfiles, caballos, torres, reyes y reinas. El profesor los seguía levantando las piezas en el camino, mientras Aníbal desgranaba a la carrera sus nociones de ajedrez:
      -¡Apertura, medio juego, final! ¡Final, Finaaaal!
      -¿Querés que te diga? Me quedo con el truco, que no mata a nadie –concluyó don Antonio.'
    end

    let(:words) {Vidibus::Words.new(input)}

    it 'should return a list of words without stopwords, ordered by occurrence' do
      words = Vidibus::Words.new('To tell a long story short, it\'s necessary to tell it briefly without fluff!')
      words.keywords.should eql(%w[tell long story short necessary briefly fluff])
    end

    it 'should only remove stopwords of given locale' do
      words = Vidibus::Words.new('To tell a long story short, it\'s necessary to tell it briefly without fluff!')
      words.locale = :de
      words.keywords.should eql(%w[to tell a long story short it's necessary it briefly without fluff])
    end

    it 'should return only 20 keywords by default' do
      keywords = words.keywords
      keywords.length.should eql(20)
      keywords.should eql(%w[no aníbal dama defensa profesor ajedrez juego loquito sordo peones mesa don antonio parece piezas india concentración atención ustedes club])
    end

    it 'should accept an optional length param' do
      words.keywords(30).length.should eql(30)
    end

    it 'should not fail on nil input string' do
      words = Vidibus::Words.new(nil)
      words.keywords.should eq []
    end
  end

  describe '.stopwords' do
    it 'should return a list of stop words of all languages available' do
      list = Vidibus::Words.stopwords
      list.should include('also') # de
      list.should include('able') # en
    end

    it 'should return a list of stop words for given locale only' do
      list = Vidibus::Words.stopwords(:de)
      list.should include('also')
      list.should_not include('able')
    end

    it 'should accept multiple locales' do
      list = Vidibus::Words.stopwords(:de, :en)
      list.should include('also') # de
      list.should include('able') # en
    end

    it 'should return an empty array if no stop words are available for given locale' do
      Vidibus::Words.stopwords(:fr).should be_empty
    end
  end

  describe '.words' do
    it 'should return an array of words from given string' do
      Vidibus::Words.words('Hello').should eql(%w[Hello])
    end

    it 'should remove dates with slashes' do
      Vidibus::Words.words('On 01/12/2011 we will party!').should eql(%w[On 01/12/2011 we will party])
    end

    it 'should preserve dates with dashes' do
      Vidibus::Words.words('On 12-01-2011 we will party!').should eql(%w[On 12-01-2011 we will party])
    end

    it 'should preserve dates with dots' do
      Vidibus::Words.words('On 12.01.2011 we will party!').should eql(%w[On 12.01.2011 we will party])
    end

    it 'should preserve combined words' do
      Vidibus::Words.words('sign-on').should eql(%w[sign-on])
    end

    it 'should preserve decimals with dots' do
      Vidibus::Words.words('10.5').should eql(%w[10.5])
    end

    it 'should preserve decimals with commas' do
      Vidibus::Words.words('10,5').should eql(%w[10,5])
    end

    it 'should preserve apostrophs' do
      Vidibus::Words.words('It\'s on!').should eql(%w[It's on])
    end

    it 'should preserve special chars' do
      Vidibus::Words.words('Hola señor').should eql(%w[Hola señor])
    end

    it 'should remove non-word chars' do
      Vidibus::Words.words('¿cómo está?').should eql(%w[cómo está])
    end

    it 'should remove non-word chars within sentences' do
      Vidibus::Words.words('Hola señor, ¿cómo está?').should eql(%w[Hola señor cómo está])
    end

    it 'should remove double non-word chars' do
      Vidibus::Words.words('-¡Defensa india de dama!-').should eql(%w[Defensa india de dama])
    end
  end

  describe '.sort_by_occurrence' do
    it 'should sort a list of words by occurrence' do
      words = Vidibus::Words.words('Children\'s song: Hey, hey Wickie, hey Wickie, hey!')
      Vidibus::Words.sort_by_occurrence(words).should eql(%w[hey wickie children's song])
    end

    it 'should also weigh the position of words' do
      words = Vidibus::Words.words('third: first second third')
      Vidibus::Words.sort_by_occurrence(words).should eql(%w[third first second])
    end
  end
end
