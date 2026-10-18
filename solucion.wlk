class Guerrero {
    const nivelEnergiaInicial
    var potencialOfensivo
    var nivelExperiencia
    var nivelEnergia
    var factorDisminucionEnergiaTrasAtaque = 0.1
    
    method nivelEnergia() = nivelEnergia

    method nivelExperiencia() = nivelExperiencia

    method estaMuerto() = nivelEnergia == 0

    method atacarAGuerrero(unGuerrero) {
        unGuerrero.recibirAtaque(potencialOfensivo) 
    }

    method recibirAtaque(potencialDelAtacante) {
        const danioRecibido = (factorDisminucionEnergiaTrasAtaque * potencialDelAtacante)
        nivelEnergia = 0.max(nivelEnergia - danioRecibido)
        nivelExperiencia += 1
    }

    method comerSemillaErmitanio() {
        nivelEnergia = nivelEnergiaInicial
    }
}