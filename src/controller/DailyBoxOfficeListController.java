package controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.IntStream;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@WebServlet("/dailyBoxOfficeList.do")
public class DailyBoxOfficeListController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		Date date = new Date(); //오늘날짜 date 객체 만들기
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyymmdd"); // 날짜 형식 맞추기

		String today = simpleDateFormat.format(date); // 오늘날짜로 조회

		//영화진흥위원회 에서 openApi가져올 주소
		String urlBuilder = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/"
				+ "searchDailyBoxOfficeList.json?key=f5eef3421c602c6cb7ea224104795888&targetDt=" + today;

		StringBuffer stringBuffer = new StringBuffer();
		URL url = new URL(urlBuilder);
		Reader reader = new InputStreamReader(url.openStream());
		BufferedReader bufferedReader = new BufferedReader(reader);
		String dailyBoxOffice;
		String dailyBoxOfficeList = "";

		//bufferedReader로 읽어온 dailyBoxOffice가 있으면 dailyBoxOfficeList에 값을 추가
		while ((dailyBoxOffice = bufferedReader.readLine()) != null) {
			dailyBoxOfficeList += dailyBoxOffice;
		}

		System.out.println(dailyBoxOfficeList.toString());
		
		//response에 가져온 정보 json으로 붙임
		response.setContentType("application/json");
		response.setCharacterEncoding("utf8");
		response.getWriter().write(dailyBoxOfficeList);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

	}

}
