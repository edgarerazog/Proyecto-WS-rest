package get;

import org.json.CDL;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.stream.Collectors;

public class JavaConvertCsvToJson {

    public void convert(){

        InputStream inputStream = JavaConvertCsvToJson.class.getClassLoader().getResourceAsStream("Data.csv");
        String csvAsString = new BufferedReader(new InputStreamReader(inputStream)).lines().collect(Collectors.joining("\n"));
        String json = CDL.toJSONArray(csvAsString).toString();
        System.out.println(json);

        try {
            Files.write(Path.of("src/test/java/get/output.json"), json.getBytes(StandardCharsets.UTF_8));
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }


}
