class Guerrero {
    const nivelEnergiaInicial
    var potencialOfensivo
    var nivelExperiencia
    var nivelEnergia
    var traje
    const factorDisminucionEnergiaTrasAtaque = 0.1

    method nivelEnergia() = nivelEnergia

    method nivelExperiencia() = nivelExperiencia

    method traje() = traje

    method estaMuerto() = nivelEnergia == 0

    method potencialOfensivo() = potencialOfensivo

    method cantidadPiezasTraje() = traje.cantidadPiezas()

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

    method cantidadPiezas() = 1
}

class TrajeDeEntrenamiento {
    method proteccion(potencialDelAtacante) = 0

    method experienciaGanada() = trajesDeEntrenamiento.multiplicadorExperiencia()

    method cantidadPiezas() = 1

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

    method piezas() = piezas

    method gastado() = piezas
            .all { pieza => pieza.estaGastada() }

    method proteccion(potencialDelAtacante) =
        piezas
            .filter({ pieza => !pieza.estaGastada() })
            .sum({ pieza => pieza.resistencia() })
        
    method experienciaGanada() =
    piezas.count({ pieza => !pieza.estaGastada() }) / piezas.size()

    method cantidadPiezas() = piezas.size()
}

class Modalidad {
    const cantidadPeleadores 
    method seleccionar(peleadores) = peleadores.take(cantidadPeleadores)
}

class PowerIsBest inherits Modalidad {
    override method seleccionar(peleadores) = peleadores.sortedBy({ a, b => a.potencialOfensivo() > b.potencialOfensivo() }).take(cantidadPeleadores)
}

class Funny inherits Modalidad {
    override method seleccionar(peleadores) = peleadores.sortedBy({ a, b => a.cantidadPiezasTraje() > b.cantidadPiezasTraje() }).take(cantidadPeleadores)
}

class Surprise inherits Modalidad {
    override method seleccionar(peleadores) = peleadores.randomized().take(cantidadPeleadores)
}

class Torneo {
    const participantes = []
    var modalidad 
    method participantes() = participantes

    method cambiarModalidad(nueva) { modalidad=nueva}

    method inscripcion(peleadores) {
        participantes.addAll(modalidad.seleccionar(peleadores))
    }
}






