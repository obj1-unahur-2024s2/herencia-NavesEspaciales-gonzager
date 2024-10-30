class Nave {
  var velocidad = 0
  var direccion = 0
  var combustible = 0

  method initialize(){
    if (not velocidad.between(0, 100000) ||
      not direccion.between(-10,10)) 
      self.error("No se puede instanciar")
  }

  method acelerar(cuanto){
    velocidad =  100000.min(velocidad + cuanto)
  }

  method desacelerar(cuanto) {
    velocidad = 0.max(velocidad - cuanto)
  }

  method irHaciaElSol() {
    direccion = 10
  }

  method escaparDelSol() {
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

  method cargarCombustible(unaCantidad) {
    combustible += unaCantidad
  }
  method prepararViaje() 

  method accionAdicional(){
    self.cargarCombustible(30000)
    self.acelerar(5000)
  }

  method estaTranquila() = combustible >= 4000 
    and velocidad <= 12000
}


class NaveBaliza inherits Nave{
  var colorBaliza = "verde"

  method cambiarColorDeBaliza(colorNuevo){
    if (not ["verde","rojo","azul"].contains(colorNuevo))
      self.error("No es un color permitido")
    colorBaliza = colorNuevo
  }

  override method prepararViaje() {
    colorBaliza ="verde"
    self.ponerseParaleloAlSol()
    self.accionAdicional()
  }

  override method estaTranquila() = 
   super() and colorBaliza != "rojo"
}

class NavePasajero inherits Nave {
  const property cantPasajeros 
  var racionesComida = 0
  var racionesBebida = 0

  method cargarRacionesComida(unaCantidad){
    racionesComida += unaCantidad
  }
  method cargarRacionesBebida(unaCantidad) {
    racionesBebida = racionesBebida + unaCantidad
  }
  override method prepararViaje() {
    self.cargarRacionesComida(4 * cantPasajeros )
    self.cargarRacionesBebida(6 * cantPasajeros)
    self.acercarseUnPocoAlSol()
    self.accionAdicional()
  }

}

class NaveHospital inherits NavePasajero{
  var property quirofanosPreparados=false
  override method estaTranquila()= 
    super() and  not quirofanosPreparados
}


class NaveCombate inherits Nave {
  var visibilidad = true
  var misiles = false
  const mensajes = []
  method ponerseVisible(){
    visibilidad = true
  }
  method ponerseInvisible() {
    visibilidad = false
  }
  method estaInvisible() = visibilidad

  method desplegarMisiles() {
    misiles = true
  }
  method replegarMisiles(){
    misiles = false
  }
  method misilesDesplegados() = misiles

  method emitirMensaje(mensaje) {
    mensajes.add(mensaje)
  }

  method mensajesEmitidos() = mensajes
 
  method primerMensajeEmitido() = mensajes.first()

  method ultimoMensajeEmitido() = mensajes.last()

  method esEscueta() = not mensajes.any { m => m.size() > 30}

  method emitioMensaje(mensaje) = mensaje.contains(mensaje)

  override method prepararViaje() {
    self.ponerseVisible()
    self.replegarMisiles()
    self.acelerar(15000)
    self.emitirMensaje("Saliendo en misión")
    self.accionAdicional()
    self.acelerar(15000)
  }

  override method estaTranquila()=
    super() && not misiles
}


class NaveSigilosa inherits NaveCombate {
  override method estaTranquila()= 
    super() and not self.estaInvisible()
}