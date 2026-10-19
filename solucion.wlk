class Guerrero {
    const nivelEnergiaInicial
    var potencialOfensivo
    var nivelExperiencia
    var nivelEnergia
    var traje
    var factorDisminucionEnergiaTrasAtaque = 0.1

    method nivelEnergia() = nivelEnergia

    method nivelExperiencia() = nivelExperiencia

    method traje() = traje

    method estaMuerto() = nivelEnergia == 0

    method cambiarTraje(nuevoTraje) {
        traje = nuevoTraje
    }

    method atacarAGuerrero(unGuerrero) {
        unGuerrero.recibirAtaque(potencialOfensivo)
    }

    method recibirAtaque(potencialDelAtacante) {
        const danioRecibido = (factorDisminucionEnergiaTrasAtaque * potencialDelAtacante) - traje.proteccion(potencialDelAtacante)
        nivelEnergia = 0.max(nivelEnergia - danioRecibido)
        nivelExperiencia += traje.experienciaGanada()
    }

    method comerSemillaErmitanio() {
        nivelEnergia = nivelEnergiaInicial
    }
}

class TrajeComun {
    const porcentajeProteccion

    method proteccion(potencialDelAtacante) = potencialDelAtacante * porcentajeProteccion / 100

    method experienciaGanada() = 1
}

class TrajeDeEntrenamiento {
    method proteccion(potencialDelAtacante) = 0

    method experienciaGanada() = trajesDeEntrenamiento.multiplicadorExperiencia()
}

object trajesDeEntrenamiento {
    var property multiplicadorExperiencia = 2
}
class Piezas {
    const property resistencia
    var property desgaste = 0
    
    method estaGastada()= desgaste >= 20
}
class TrajeModularizado {
    const piezas
    method gastado() = piezas
            .all { pieza => pieza.estaGastada() }
    method proteccion(potencialDelAtacante) =
        piezas
            .filter({ pieza => !pieza.estaGastada() })
            .sum({ pieza => pieza.resistencia() })
        
    method experienciaGanada() =
    piezas.count({ pieza => !pieza.estaGastada() }) / piezas.size()
}