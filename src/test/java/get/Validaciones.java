package get;

import org.jetbrains.annotations.NotNull;

public class Validaciones {

    public boolean validacionFecha(String fechav12,String fechav10){

        int longitud1 = fechav10.length();
        int longitud2 = fechav12.length();

        boolean fechaValidada = false;

        if(longitud1 == 8 && longitud1 == 8){
            boolean uno = fechav10.matches("[0-9]*");
            boolean dos = fechav12.matches("[0-9]*");
            if(uno == true && dos == true){
                fechaValidada = true;
            }
        }

        return fechaValidada;
    }

    public boolean validacionHora(@NotNull String horav12, String horav10){

        int longitud1 = horav12.length();
        int longitud2 = horav10.length();

        boolean horaValidada = false;

        if(longitud1 == 8 && longitud1 == 8){
            boolean horaV12 = horav12.substring(0,1).matches("[0-9]*");
            boolean minutosV12 = horav12.substring(3,4).matches("[0-9]*");
            boolean segundosV12 = horav12.substring(6,7).matches("[0-9]*");
            boolean puntosHoraV12 = String.valueOf(horav12.charAt(2)).matches(":");
            boolean puntossegundosV12 = String.valueOf(horav12.charAt(5)).matches(":");

            boolean horaV10 = horav12.substring(0,1).matches("[0-9]*");
            boolean minutosV10 = horav12.substring(3,4).matches("[0-9]*");
            boolean segundosV10 = horav12.substring(6,7).matches("[0-9]*");
            boolean puntosHoraV10 = String.valueOf(horav10.charAt(2)).matches(":");
            boolean puntossegundosV10 = String.valueOf(horav10.charAt(5)).matches(":");

            if(horaV10 == true && minutosV10 == true && segundosV10 == true && puntosHoraV10 == true
                    && puntossegundosV10 == true && horaV12 == true && minutosV12 == true
                    && segundosV12 == true && puntosHoraV12 == true && puntossegundosV12 == true){

                horaValidada = true;
            }
        }

        return horaValidada;
    }


    public boolean validacionErrores(String errorv10,String errorv12){

        boolean validacionErrores = false;
        String[] error1 = errorv10.split(" ");
        System.out.println(error1[0]);
        String[] error2 = errorv12.split(" ");
        System.out.println(error2[0]);
        if(error1[0] == "XML000" && error2[0] == "XML000"){
            validacionErrores = true;
        }




        return validacionErrores;
    }

}
