package get;


/*public class Runner {
    @Karate.Test
    Karate userGet(){
        return Karate.run().relativeTo(getClass());
    }
}*/


import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import net.masterthought.cucumber.Configuration;
        import net.masterthought.cucumber.ReportBuilder;
        import org.apache.commons.io.FileUtils;
        import org.junit.jupiter.api.Assertions;
        import org.junit.jupiter.api.Test;
        import java.io.File;
        import java.util.ArrayList;
        import java.util.Collection;
        import java.util.List;
public class RunnerServices {
    @Test
    public void testParallel() {
        Results results = Runner.path("")
                .outputCucumberJson(true)
                .tags("~@ignore")
                .parallel(1);
        generateReport(results.getReportDir());
        Assertions.assertTrue(results.getFailCount() == 0, results.getErrorMessages());
    }

    public static void generateReport(String karateOutputPath) {
        Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[]{"json"}, true);
        List<String> jsonPaths = new ArrayList<String>(jsonFiles.size());
        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
        Configuration config = new Configuration(new File("target"), "Prueba 201A");
        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();
    }
}