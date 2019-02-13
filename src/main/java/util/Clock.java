package util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Clock {

	public static String getCurrentTime() {
		long time = System.currentTimeMillis();
		SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");
		return dayTime.format(new Date(time));
	}
	
}
