package get;


import net.minidev.json.JSONObject;
import net.minidev.json.parser.JSONParser;
import net.minidev.json.parser.ParseException;

import java.sql.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.logging.Logger;


public class ConectarDBV12 {

    public Connection getConnV12() throws ClassNotFoundException {

        Connection con = null;

        try {
            //ResourceBundle rd = ResourceBundle.getBundle("ParametrosIniciales.properties");
            // driver name for AS400
            //String loadDriver = rd.getString("com.ibm.as400.access.AS400JDBCDriver");
            //String loadDriver = "com.ibm.as400.access.AS400JDBCDriver";
            // url of the database
            String dbURL = "jdbc:as400:10.160.1.82;database name=E20DEE8V";

            // username to connect db
            String dbUSERNAME = "GYFQA6";

            // password to connect db
            String dbPASSWORD = "GIROSQA7";

            // load the driver
            Class.forName("com.ibm.as400.access.AS400JDBCDriver");

            // get the connection
            con = DriverManager.getConnection(dbURL, dbUSERNAME, dbPASSWORD);

            Logger logger = Logger.getLogger(ConectarDBV12.class.getName());

            if (con != null) {
                logger.info("Conexion a BD exitosa");
                return con;
            } else {
                logger.info("Conexion a BD fallida");
                return con;
            }

        } catch (Exception e) {
            System.out.println("Ha ocurrido un error :( " + e.getMessage());
            return con;
        }

    }

    public JSONObject getDataCountSavingSuccessful(Connection con,Integer estadoCuenta) {
        String JsonResult = "";
        try (PreparedStatement preparedStatement = con.prepareStatement("SELECT * FROM GYFPROAS.SIIN01 N01  INNER JOIN GYFPROAS.SIIC40P C40P ON C40P.C40FUM = N01.N01NID INNER JOIN GYFPROAS.SIIC45 C45 ON C45.C45NID = C40P.C40FUM WHERE N01.N01EST = "+estadoCuenta)) {

            //Statement st = con.createStatement();

            //ResultSet rs = st.executeQuery("select * from gyfproas.siin01 limit 1");

            ResultSet rs = preparedStatement.executeQuery();

            String fecha = String.valueOf(LocalDate.now());
            fecha = fecha.replace("-","");

            LocalTime localTime = LocalTime.now();
            String hora = String.valueOf(localTime);
            hora = hora.substring(0,8);

            String mensajeError = null;
            String cel = null;
            String responseCode = null;





            try{
                rs.next();
                if(estadoCuenta.equals(902)){
                    mensajeError = "la cuenta de ahorros esta saldada";
                    cel = "";
                    responseCode = "40";


                }else if(estadoCuenta.equals(901)){
                    mensajeError = "la cuenta de ahorros esta cancelada";
                    cel = "";
                    responseCode = "50";
                }else {
                    mensajeError = "";
                    cel = rs.getString("C45TE2");
                    responseCode = "00000";
                }
                JsonResult = "{ " +
                        "\"msgError\": \""+mensajeError+"\" ," +
                        "\"id\": \"" + rs.getString("C40NID").replace(" ","") + "\" ," +
                        "\"countNumber\": \"00" + rs.getString("N01NPR") + "\" ," +
                        "\"celNumber\": \"" + cel + "\" ," +
                        "\"shortName\": \"\" ," +
                        "\"longName\": \"\" ," +
                        "\"requestDate\": \"" + fecha + "\" ," +
                        "\"requestHour\": \"" + hora + "\" ," +
                        "\"responseCode\": \"" + responseCode + "\" ," +
                        "\"ipAddress\": \"10.160.1.90\" " +
                        "}";
            }catch (Exception e){
                String estadoCuentaText = null;

                if(estadoCuenta.equals(1)){
                    estadoCuentaText = "Activa";
                } else if (estadoCuenta.equals(901)) {
                    estadoCuentaText = "cancelada";
                } else if (estadoCuenta.equals(902)) {
                    estadoCuentaText = "saldada";
                }


                e.getMessage();
                System.out.println("No existe un usuario con estado de cuenta :"+ estadoCuentaText);
                JsonResult = "{ " +
                        "\"msgError\": \""+"No se han encontrado resultados con los valores ingresados"+"\" ," +
                        "\"id\": \"" + "" + "\" ," +
                        "\"countNumber\": \"00" + "00000000000000000" + "\" ," +
                        "\"celNumber\": \"\" ," +
                        "\"shortName\": \"\" ," +
                        "\"longName\": \"\" ," +
                        "\"requestDate\": \"" + fecha + "\" ," +
                        "\"requestHour\": \"" + hora + "\" ," +
                        "\"responseCode\": \"" + "99" + "\" ," +
                        "\"ipAddress\": \"10.160.1.90\" " +
                        "}";
            }



            System.out.println(JsonResult);
            JSONParser parser = new JSONParser(JSONParser.MODE_JSON_SIMPLE);
            return (JSONObject) parser.parse(JsonResult);
            //con.close();

        } catch (SQLException e) {
            System.out.println("Esto ocurrio al realizar la consulta: " + e.getMessage());
            e.printStackTrace();
        } catch (ParseException e) {
            throw new RuntimeException(e);
        }

        return null;
    }




    public JSONObject getParameters201AV12(Connection con,Integer estadoCuenta) {
        String JsonResult = "";
        try (PreparedStatement preparedStatement = con.prepareStatement("SELECT * FROM GYFPROAS.SIIN01 N01 INNER JOIN GYFPROAS.SIIC40P C40P ON C40P.C40FUM = N01.N01NID INNER JOIN GYFPROAS.SIIC45 C45 ON C45.C45NID = C40P.C40FUM WHERE N01.N01EST = "+estadoCuenta)) {

            //Statement st = con.createStatement();

            //ResultSet rs = st.executeQuery("select * from gyfproas.siin01 limit 1");

            ResultSet rs = preparedStatement.executeQuery();
            System.out.println(rs);

            try{
                rs.next();
                JsonResult = "{ " +
                        "\"id\": \"" + rs.getString("C40NID").replace(" ","") + "\" ," +
                        "\"countNumber\": \"" + rs.getString("N01NPR") + "\" ," +
                        "\"tipId\": \"" + rs.getString("C40TID") + "\" " +
                        "}";
            }catch (Exception e){
                e.getMessage();
                JsonResult = "{ " +
                        "\"id\": \"000000\" ," +
                        "\"countNumber\": \"00000000000000000\" ," +
                        "\"tipId\": \"1\" " +
                        "}";
            }




            /*JsonResult = "{ " +
                    "\"id\": \"" + rs.getString("C40NID").replace(" ","") + "\" ," +
                    "\"countNumber\": \"" + rs.getString("N01NPR") + "\" ," +
                    "\"tipId\": \"" + rs.getString("C40TID") + "\" " +
                    "}";*/
            System.out.println(JsonResult);
            JSONParser parser = new JSONParser(JSONParser.MODE_JSON_SIMPLE);
            return (JSONObject) parser.parse(JsonResult);
            //con.close();

        } catch (SQLException e) {
            System.out.println("Esto ocurrio al realizar la consulta: " + e.getMessage());
            e.printStackTrace();
        } catch (ParseException e) {
            throw new RuntimeException(e);
        }

        return null;
    }


}
