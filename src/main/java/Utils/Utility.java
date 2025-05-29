package Utils;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

public class Utility {

    public static boolean isExpired(LocalDate dateInput) {
        LocalDate today = LocalDate.now();
        return dateInput.isBefore(today);
    }


    public static long daysLeft(LocalDate dateInput) {
        LocalDate today = LocalDate.now(); 
        long dayRemain = ChronoUnit.DAYS.between(today, dateInput);
        return dayRemain > 0 ? dayRemain : 0;
    }


    public static LocalDate getCurrentDate() {
        return LocalDate.now();
    }
}
