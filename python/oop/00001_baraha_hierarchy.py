class Baraha:
    def __init__( self, antas, suit ):
        self.antas = antas
        self.suit = suit
        self.way, self.dos = self._puntos()

class BarahaNumero( Baraha ):
    def _puntos( self ):
        return int(self.antas), int(self.antas)

class BarahaAlas( Baraha ):
    def _puntos( self ):
        return 1, 1

class BarahaTao( Baraha ):
    def _puntos( self ):
        return 10, 10
