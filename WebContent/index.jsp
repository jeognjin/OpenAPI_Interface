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
  <!-- 데이터 테이블 cdn -->
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.12.1/datatables.min.css"/>
<script type="text/javascript" src="https://cdn.datatables.net/v/dt/dt-1.12.1/datatables.min.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>


</head>

<script>
	var url = "${pageContext.request.contextPath}";
	$(document).on("click","#dailyBoxOfficeList",function() {
		$.get(url + "/dailyBoxOfficeList.do", function(responseJson) {
			console.log("responseJson",responseJson);
			var item = responseJson.boxOfficeResult.dailyBoxOfficeList;
	 		console.log("item",item);
			console.log("item[0].movieNm",item[0].movieNm);
			console.log("item[0].openDt",item[0].openDt);
			console.log("item[0].salesAcc",item[0].salesAcc); 
	
			//오늘 날짜 뽑아서 today 변수에 형식 만들어주기
			var now = new Date();      
			var year= now.getFullYear();      
			var mon = (now.getMonth()+1)>9 ? ''+(now.getMonth()+1) : '0'+(now.getMonth()+1);      
			var day = now.getDate()>9 ? ''+now.getDate() : '0'+now.getDate();                    
			var today = year + '년 ' + mon + '월 ' + day + '일';

			//제목 적어주기
		 	$($("#dailyBoxOfficeListResult")).prepend("<h1>"+today+" 박스오피스 영화목록</h1>"); 
			
			//table display 변경
			var ui =document.getElementById("data_list");
		    ui.style.display="block";
					
			$('#data_list').dataTable({
				 data: item,
				columns: [
					{data: "rank"},
					{data: "movieNm"},
					{data: "openDt"},
					{data: "salesAmt"},
					{data: "salesAcc"},
					{data: "audiAcc"},
					{data: "scrnCnt"},
					{data: "showCnt"}
				]
			});
			
	/* 		//기존 자료가 있으면 지우고 다시 작성
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
			}	
			  */
		});
	});

	
	
</script>

<script>
/* 차트 */
var url = "${pageContext.request.contextPath}";
$(document).on("click","#dailyBoxOfficeListGraph",function() {
	$.get(url + "/dailyBoxOfficeList.do", function(responseJson) {
		console.log("responseJson",responseJson);
		var item = responseJson.boxOfficeResult.dailyBoxOfficeList;
 		console.log("item",item);
		console.log("item[0].movieNm",item[0].movieNm);
		console.log("item[0].openDt",item[0].openDt);
		console.log("item[0].salesAcc",item[0].salesAcc); 

		//기존 자료가 있으면 지우고 다시 작성
		$("#dailyBoxOfficeListGraphResult").find("canvas").remove();
		$("#dailyBoxOfficeListGraphResult").find("h1").remove();
		
		//오늘 날짜 뽑아서 today 변수에 형식 만들어주기
		var now = new Date();      
		var year= now.getFullYear();      
		var mon = (now.getMonth()+1)>9 ? ''+(now.getMonth()+1) : '0'+(now.getMonth()+1);      
		var day = now.getDate()>9 ? ''+now.getDate() : '0'+now.getDate();                    
		var today = year + '년 ' + mon + '월 ' + day + '일';
		
		//제목 적어주기
		$("<h1>"+today+" 영화별 누적관객수</h1>").appendTo($("#dailyBoxOfficeListGraphResult"));
		
		//테이블에 제목줄까지 만들어서 div에 붙임
		var $canvas = $('<canvas id="myChart" style="width:100%;max-width:1000px;">').appendTo($("#dailyBoxOfficeListGraphResult"));
		var $canvas = $('<canvas id="myChart2" style="width:100%;max-width:500px;">').appendTo($("#dailyBoxOfficeListGraphResult"));
		var $canvas = $('<canvas id="myChart3" style="width:100%;max-width:500px;">').appendTo($("#dailyBoxOfficeListGraphResult"));
		
		//x,y축 값을 넣어줄 arry 생성
		var xValues = [];
		var yValues = [];
		var barColors = [
			/* "red", "green","blue","orange","brown", "yellow", "navy", "violet" */
			'rgba(255, 99, 132, 0.7)',
			'rgba(54, 162, 235, 0.7)',
			'rgba(255, 206, 86, 0.7)',
			'rgba(75, 12, 192, 0.7)',
			'rgba(163, 102, 255, 0.7)',
			'rgba(155, 159, 64, 0.7)',
			'rgba(13, 159, 64, 0.7)',
			'rgba(195, 159, 64, 0.7)',
			'rgba(235, 159, 64, 0.7)',
			'rgba(26, 79, 84, 0.7)'
			];

		//item에서 값을 추출해서 array에 저장
	for(var i = 0; i < 10; i++){
			xValues[i] = item[i].movieNm;
		}
		
	for(var i = 0; i < 10; i++){
			yValues[i] = item[i].audiAcc;
		}
	
		//차트 생성 bar타입
		new Chart("myChart", {
		  type: "bar",
		  data: {
		    labels: xValues,
		    datasets: [{
		      backgroundColor: barColors,
		      data: yValues
		    }]
		  },
		  options: {
		    legend: {display: false},
		    title: {
		      display: true,
		      text: "영화별 누적 관객수"
		    }
		  }
		});
		
		//pie 타입
		new Chart("myChart2", {
			  type: "pie",
			  data: {
			    labels: xValues,
			    datasets: [{
			      backgroundColor: barColors,
			      data: yValues
			    }]
			  },
			  options: {
			    title: {
			      display: true,
			      text: "영화별 누적 관객수"
			    }
			  }
			});
		
		//도넛 타입
		new Chart("myChart3", {
			  type: "doughnut",
			  data: {
			    labels: xValues,
			    datasets: [{
			      backgroundColor: barColors,
			      data: yValues
			    }]
			  },
			  options: {
			    title: {
			      display: true,
			      text: "영화별 누적 관객수"
			    }
			  }
			});
		
	});
});

</script>

<style>
table {
    width: 100%;
    border-top: 1px solid #444444;
    border-collapse: collapse;
    display: none;
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
  h1, dailyBoxOfficeListResult, canvas{
  margin: 30px 0;
  }

</style>
<body>

<!-- 버튼 스타일은 부트스트랩 사용 -->
<div class="container">
  <button type="button" class="btn btn-primary btn-lg btn-block" id="dailyBoxOfficeList">일별 박스오피스 목록</button>
  <div id="dailyBoxOfficeListResult">
  <h1></h1>
   <table id="data_list" class="table table-bordered">
  	<thead>
  		<tr>
  			<th>랭킹</th>
  			<th>영화제목</th>
  			<th>개봉일</th>
  			<th>당일 매출액</th>
  			<th>누적 매출액</th>
  			<th>누적 관객수</th>
  			<th>당일 상영 스크린 수</th>
  			<th>당일 상영 횟수</th>
  		</tr>
  	</thead>
  </table> 
</div>

  <button type="button" class="btn btn-default btn-lg btn-block" id="dailyBoxOfficeListGraph">일별 박스오피스 그래프</button>
  <div id="dailyBoxOfficeListGraphResult"></div>
</div>

<%-- <canvas id="myChart" style="width:100%;max-width:1000px; "></canvas> --%>

</body>
</html>