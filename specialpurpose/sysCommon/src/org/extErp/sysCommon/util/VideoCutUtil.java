package org.extErp.sysCommon.util;

import java.io.File;
import java.util.List;

public class VideoCutUtil {
	public static boolean processImg(String ffmpeg_path, String veido_path, String imgPath) {
		File file = new File(veido_path);
		if (!file.exists()) {
			System.err.println("路径[" + veido_path + "]对应的视频文件不存在!");
			return false;
		}
		List<String> commands = new java.util.ArrayList<String>();
		commands.add(ffmpeg_path);
		commands.add("-i");
		commands.add(veido_path);
		commands.add("-y");
		commands.add("-f");
		commands.add("image2");
		commands.add("-ss");
		commands.add("5");// // 这个参数是设置截取视频多少秒时的画面
		// commands.add("-t");
		// commands.add("0.001");
		commands.add("-s");
		commands.add("700x525");
		commands.add(imgPath);
		try {
			ProcessBuilder builder = new ProcessBuilder();
			builder.command(commands);
			builder.start();
			System.out.println("截取成功");
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public static void main(String[] args) {
		processImg("E:/workspace/jave/bin/it/sauronsoftware/jave/ffmpeg1.exe", "C:/Users/WuHK/Desktop/aa.flv", "C:/Users/WuHK/Desktop/aa.jpg");
	}
}
