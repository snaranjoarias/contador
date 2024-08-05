defmodule Contador do
  def iniciar do
    # Inicia elcontrolador
    controlador_pid = spawn(fn -> controlador() end)
    
    # Inicia el contador
    spawn(fn -> contador(controlador_pid) end)
  end

  defp contador(controlador_pid) do
    contador = 0

    # Bucle infinito para incrementar el contador cada segundo
    loop(contador, controlador_pid)
  end

  defp loop(contador, controlador_pid) do
    # Espera un segundo
    :timer.sleep(1000)
    
    # Incrementa el contador
    nuevo_contador = contador + 1
    
    # Envía el nuevo valor al proceso controlador
    send(controlador_pid, {:contador, nuevo_contador})
    
    # Llama recursivamente para continuar el bucle
    loop(nuevo_contador, controlador_pid)
  end

  defp controlador do
    # Bucle infinito para recibir mensajes
    loop_controlador()
  end

  defp loop_controlador do
    receive do
      {:contador, valor} ->
        # Muestra el valor recibido
        IO.puts("Valor del contador: #{valor}")
        
        # Llama recursivamente para seguir recibiendo
        loop_controlador()
    end
  end
end

# Para iniciar el programa()
Contador.iniciar()
