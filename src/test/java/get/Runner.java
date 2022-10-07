package get;

import com.intuit.karate.junit5.Karate;
public class Runner {

    @Karate.Test
    Karate userGet(){
        return Karate.run("consultar-cuenta-ahorros-activa-get.feature").relativeTo(getClass());
    }


}
