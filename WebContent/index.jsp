<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OpenAPI WaterQualityService by JeongJin</title>
<!-- 부트스트렙 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  
  <script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>

<script>
	var url = "${pageContext.request.contextPath}";
	$(document).on("click","#dailyBoxOfficeList",function() {
		$.get(url + "/dailyBoxOfficeList.do", function(responseJson) {
			console.log("responseJson",responseJson);
			var item = responseJson.boxOfficeResult.dailyBoxOfficeList;
	/* 		console.log("item",item);
			console.log("item[0].movieNm",item[0].movieNm);
			console.log(item[0].openDt);
			console.log(item[0].salesAcc); */
			
			//오늘 날짜 뽑아서 today 변수에 형식 만들어주기
			var now = new Date();      
			var year= now.getFullYear();      
			var mon = (now.getMonth()+1)>9 ? ''+(now.getMonth()+1) : '0'+(now.getMonth()+1);      
			var day = now.getDate()>9 ? ''+now.getDate() : '0'+now.getDate();                    
			var today = year + '년 ' + mon + '월 ' + day + '일';
			
			//기존 자료가 있으면 지우고 다시 작성
			$("#dailyBoxOfficeListResult").find("table").remove();
			$("#dailyBoxOfficeListResult").find("h1").remove();
			
			//제목 적어주기
			$("<h1>"+today+" 박스오피스 영화목록</h1>").appendTo($("#dailyBoxOfficeListResult"));
			
			//테이블에 제목줄까지 만들어서 div에 붙임
			var $table = $("<table>").appendTo($("#dailyBoxOfficeListResult"));
			$("<tr>").appendTo($table)
			.append($("<th>").text("랭킹"))
			.append($("<th>").text("영화제목"))
			.append($("<th>").text("개봉일"))
			.append($("<th>").text("당일 매출액"))
			.append($("<th>").text("누적 매출액"))
			.append($("<th>").text("누적 관객수"))
			.append($("<th>").text("당일 상영 스크린 수"))
			.append($("<th>").text("당일 상영 횟수"));

			//for문으로 영화 정보 추출해서 테이블에 붙이기
			for(var i = 0; i < 10; i++){
				$("<tr>").appendTo($table)
				.append($("<td>").text(item[i].rank))
				.append($("<td>").text(item[i].movieNm))
				.append($("<td>").text(item[i].openDt))
				.append($("<td>").text(item[i].salesAmt))
				.append($("<td>").text(item[i].salesAcc))
				.append($("<td>").text(item[i].audiAcc))
				.append($("<td>").text(item[i].scrnCnt))
				.append($("<td>").text(item[i].showCnt));
				/* $("#dailyBoxOfficeListResult").append($("<p>").text("랭킹" + (i+1) + " : " +item[i].movieNm)); */
			}	
		});
	});
</script>

<style>
table {
    width: 100%;
    border-top: 1px solid #444444;
    border-collapse: collapse;
  }
  th, td {
    border-bottom: 1px solid #444444;
    border-left: 1px solid #444444;
    padding: 10px;
  }
  th:first-child, td:first-child {
    border-left: none;
  }
  button{
  margin: 30px 0;
  }
  
  body{
  text-align: center;
  }
  h1{
  margin: 30px 0;
  }
</style>
<body>

<!-- 버튼 스타일은 부트스트랩 사용 -->
<div class="container">
  <button type="button" class="btn btn-primary btn-lg btn-block" id="dailyBoxOfficeList">일별 박스오피스 목록</button>
  <div id="dailyBoxOfficeListResult"></div>
  <button type="button" class="btn btn-default btn-lg btn-block" id="dailyBoxOfficeListGraph">일별 박스오피스 그래프</button>
  <div id="dailyBoxOfficeListGraphResult"></div>
</div>

  
</body>
</html>