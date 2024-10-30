class Nave {
  var velocidad = 0
  var direccion = -10
  var combustible = 0
  
  method acelerar(cuanto){
    velocidad = 100000.min(velocidad + cuanto)
  }
  method desacelerar(cuanto) {
    velocidad = 0.max(velocidad - cuanto)
  }
  method irHaciaElSol(){
    direccion = 10
  }
  method escaparDelSol(){
    direccion = -10
  }
  method ponerseParaleloAlSol() {
    direccion = 0
  }
  method acercarseUnPocoAlSol() {
    direccion = 10.min(direccion + 1)
  }
  method alejarseUnPocoDelSol() {
    direccion = (-10).max(direccion - 1)
  }

  method prepararViaje()

  method cargarCombustible(unaCantidad) {
    combustible += unaCantidad
  }

  method descargarCombustible(unaCantidad) {
    combustible = 0.max(combustible - unaCantidad)
  }

  method accionAdicionalAlViaje() {
    self.cargarCombustible(30000)
    self.acelerar(5000)
  }

  method estaTranquila() = combustible >= 4000 and velocidad <= 12000

  method recibirAmenaza(){
    self.escapar()
    self.avisar()
  }

  method escapar()
  method avisar()
}

class NaveBaliza inherits Nave {
  var colorBaliza = "verde"

  method cambiarColorDeBaliza(colorNuevo) {
    if (not ["verde", "rojo" , "azul"].contains(colorNuevo))
      self.error("Color no permitido.")
    colorBaliza = colorNuevo
  }
  override method prepararViaje(){
    self.cambiarColorDeBaliza("verde")
    self.ponerseParaleloAlSol()
    self.accionAdicionalAlViaje()
  }
  override method estaTranquila()= super() and colorBaliza != "rojo"
  override method escapar(){
    self.irHaciaElSol()
  }

  override method avisar() {
    self.cambiarColorDeBaliza("rojo")
  }
}

class NavePasajero inherits Nave {
  var cantPasajeros = 0
  var racionesComida = 0
  var racionesBebida = 0

  method agregarPasajeros(unaCantidad) {
    cantPasajeros = cantPasajeros + unaCantidad
  }
  method vaciar() {
    cantPasajeros = 0
  }
  method cargarComida(unaCantidad) {
    racionesComida += unaCantidad
  }
  method cargarBebida(unaCantidad) {
    racionesBebida += unaCantidad
  }
  override method prepararViaje(){
    self.cargarComida(4 * cantPasajeros)
    self.cargarBebida(6 * cantPasajeros)
    self.acercarseUnPocoAlSol()
    self.accionAdicionalAlViaje()
  }
  override method escapar(){
    self.acelerar(velocidad)
  }

  override method avisar() {
    racionesComida = 0.max(racionesComida - cantPasajeros)
    racionesBebida = 0.max( racionesBebida - cantPasajeros * 2)
  }
}

class NaveHospital inherits NavePasajero {
  var property quirofanosPreparados = false 
  override method recibirAmenaza() {
    super()
    quirofanosPreparados=true
  }
}

class NaveCombate inherits Nave {
  const property mensajesEmitidos = []
  var estaInvisible = false
  var misilesDesplegados = false
  method ponerseVisible() {
    estaInvisible = false
  } 
  method ponerseInvisible() {
    estaInvisible = true
  }

  method estaInvisible() = estaInvisible

  method desplegarMisiles(){
    misilesDesplegados = true
  }
  method replegarMisiles() {
    misilesDesplegados = false
  }
  method misilesDesplegados() = misilesDesplegados

  method emitirMensaje(mensaje) {
    mensajesEmitidos.add(mensaje)
  }
  method primerMensajeEmitido() = mensajesEmitidos.first()
  method ultimoMensajeEmitido() = mensajesEmitidos.last()
  method esEscueta() = not mensajesEmitidos.any { m=> m.size() >30 }
  method esEscueta2() = mensajesEmitidos.all { m=> m.size() <= 30 }
  method emitioMensaje(mensaje) = mensajesEmitidos.contains(mensaje)

  override method prepararViaje() {
    self.ponerseVisible()
    self.replegarMisiles()
    self.acelerar(15000)
    self.emitioMensaje("Saliendo en misión")
    self.accionAdicionalAlViaje()
  }

  override method accionAdicionalAlViaje() {
    super()
    self.acelerar(15000)
  }

  override method estaTranquila() = super() and not misilesDesplegados
    override method escapar(){
    self.acercarseUnPocoAlSol()
    self.acercarseUnPocoAlSol()
  }

  override method avisar() {
    self.emitirMensaje("Amenaza recibida")
  }
}

class NaveSigilosa inherits NaveCombate {
  override method estaTranquila() = super() and not estaInvisible
  override method recibirAmenaza() {
    super()
    self.desplegarMisiles()
    self.ponerseInvisible()
  }
}