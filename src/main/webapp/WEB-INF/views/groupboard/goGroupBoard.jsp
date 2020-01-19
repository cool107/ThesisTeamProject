<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>チーム 掲示板</title>

<!-- Custom fonts for this template-->
<link
	href="${pageContext.request.contextPath}/resources/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=M+PLUS+Rounded+1c:400,500,700&amp;subset=japanese"
	rel="stylesheet" type='text/css'>


<!-- Custom styles for this template-->
<link
	href="${pageContext.request.contextPath}/resources/css/sb-admin-2.min.css"
	rel="stylesheet">
<style>
body {
	font-family: 'M PLUS Rounded 1c', sans-serif;
}

button {
	font-family: 'M PLUS Rounded 1c', sans-serif;
}

.dropdown-content a:hover {
	background-color: #3C85C4; color:white;
}

#plus_minus{
 max-width: 100%;
}
	
team_number_button{
	size:300px;
}

.card shadow mb-4{
	width : 100%;
}

/* 차트 */


.flex-wrapper {
  display: flex;
  flex-flow: row nowrap;
}

.single-chart {
  width: 33%;
  justify-content: space-around ;
}

.circular-chart {
  display: block;
  margin: 10px auto;
  max-width: 80%;
  max-height: 250px;
}

.circle-bg {
  fill: none;
  stroke: #eee;
  stroke-width: 3.8;
}

.circle {
  fill: none;
  stroke-width: 2.8;
  stroke-linecap: round;
  animation: progress 1s ease-out forwards;
}

@keyframes progress {
  0% {
    stroke-dasharray: 0 100;
  }
}

.circular-chart.orange .circle {
  stroke: #ff9f00;
}

.circular-chart.green .circle {
  stroke: #4CC790;
}

.circular-chart.blue .circle {
  stroke: #3c9ee5;
}

.percentage {
  fill: #666;
  font-family: sans-serif;
  font-size: 0.5em;
  text-anchor: middle;
}

.badge-counter {
    position: absolute;
    -webkit-transform: scale(.7);
    transform: scale(.7);
    -webkit-transform-origin: top right;
    transform-origin: top right;
    right: -0.3rem;
    margin-top: -.25rem;
    background-color: red;
}
</style>
<script
	src="${pageContext.request.contextPath}/resources/vendor/jquery/jquery.min.js"></script>
<script type="text/javascript">

	//멤버수 입력
		var member_number = 0;
		var avg_seven = 0;

		$(function() {		
	
			selectMsgCount();
			$('#selectFiveMessages').on('click', selectFive);
			$("#chatForm").on("click", goChatForm).css('cursor', 'pointer');
			$("#go_groupBoard").on('click', go_groupBoard);
				all_list_avg_days_progress();					
				setTimeout(function(){
					list_progress();
					list_avg_days_progress();
				},100);
				
				log_print();
		});
		
		function selectMsgCount(){
			var toId = '${sessionScope.loginId}';
			$.ajax({
				method : 'get'
				, url : 'selectMsgCount'
				, data : {'toId' : toId}
				, success : function(resp){
					$("#msgCount").text(resp);
				}
			})
		}
		
		function goChatForm() {
			window.open('/chatForm', 'text',
					'width=610, height=557, resizable = no, scrollbars = no');
		}
		
		function go_groupBoard() {
			location.href = "groupboard_list";
		}

		function selectFive() {
			$.ajax({
				method : 'get',
				url : 'selectFiveMessages',
				success : outputMsg,
				error : function(resp) {
					console.log(resp);
				}
			});
		}

		function outputMsg(resp) {

			var content = '<table class="table table-bordered" id="msgTable" cellspacing="0" style="table-layout:fixed; font-size:12px;">';
			if (resp == "") {
				content += '<p style="text-align:center; font-weight: bold; font-size:25px; color:#1cc88a;"><i class="fas fa-dove fa-lg" style="color:#1cc88a;"></i> ${sessionScope.loginName}様のメッセージ</p>';
				content += '<tr style="text-align:center; font-size:15px;"><td colspan="2">新着メッセージがありません。</td></tr>';
			}
			if (resp != "") {
				content += '<p style="text-align:center; font-weight: bold; font-size:25px; color:#1cc88a;"><i class="fas fa-dove fa-lg" style="color:#1cc88a;"></i> ${sessionScope.loginName}様のメッセージ</p>';
				$
						.each(
								resp,
								function(index, item) {
									content += '<tr>';
									content += '<td class="fromId" style="width:80px; color:black;">'
											+ item.fromId + '</td>';
									content += '<td class="messageContent" style="text-overflow:ellipsis; overflow:hidden; white-space:nowrap;">'
											+ '<a href = "#" id = "getMessage">'
											+ item.messageContent
											+ '</a>'
											+ '</td>';
									content += '<td class="messageIndate" style="width:200px; color:black;">'
											+ item.messageIndate + '</td>';
									content += '</tr>';
								});
			}

			content += '</table>';
			$('.listOfMessage').html(content);
		};
		
		
		
		function list_progress(){
	 		
			$.ajax({
	 			method:'POST',
	 			url:'list_progress',
	 			success : function(resp){
	 				if(resp != null){	  		
	 					card_body_plus2(resp);	 					
	 					
	 			 		$.ajax({
	 			 			method:'POST',
	 			 			url:'select_7_day_avg_progress',
	 			 			success : function(resp){
	 			 				if(resp != null){	 			 					
	 			 					percent(resp);
	 			 					console.log(resp);
	 			 				}else{
	 			 					alert("データの読み込みに失敗しました");
	 			 				}
	 			 				
	 			 			}
	 			 			
	 			 		});
	 			 		
	 			 		
	 				}else{
	 					alert("間違っているアクセスです。");
	 					return;	 					
	 				}
	 			}
	 			
	 			
	 		});

		} 
		

		function list_avg_days_progress(){		
			 
			$.ajax({
				method:'post',
				url:'select_all_avg_day',
				success : function(resp){
					if(resp != null){
						insert_today_process(resp);
						list_progress();
					}else{
						alert('データがありません。');
						 list_progress();
					}
				}
			});
			
		}
		
	function all_list_avg_days_progress(){
			
			$.ajax({
				method:'post',
				url:'all_select_7_day_avg_progress',
				success : function(resp){
					if(resp != null){							
					 avg_seven=JSON.stringify(resp);	
					 list_progress();
					 list_avg_days_progress();
					}else{
						alert('データがありません。');
						 list_progress();
					}
				}
			});			
		}
	
	//팀원 로그 셀렉트
	function log_print(){
		
		$.ajax({
			method : 'POST',
			url : 'progress_log',
			success : function(resp){				
				if(resp != null){
					progress_log(resp);				
				}else{
					alert("データがありません。");
				}
			}
			
		});
		
	}
			//진 행률 로그 그리는 테입
		function progress_log(resp){

			var data = '';			  
	            data += '<table>';   
	            $.each(resp,function(index,item){
		            data +='<tr><td>'+item.pro_date;
					data += ' '+item.name+'様が'+item.progress_per+'%を登録しました。<del_group class="fas fa-trash-alt" data-sno="'+item.progressNum+'"/></td>';			          
	            });      
	            
	            data +='</table>';

	            
	            if(resp == ''){
	            	  $('#log_print').html('登録されているデータがありません。');	      
	            }else{
		            $('#log_print').html(data);	            	            	
	            }
	            
	            $('del_group').click(delete_progress);
		}
		
		function insert_today_process(resp){
			
			var progress_per = 0;
			var new_progress =0;
		
			new_progress=JSON.stringify(resp.progress_per);			
	
			if(resp==''){
				
				new_progress=0;
			}
			
			var data = '';			  
			var data = '';			            
            data +='<div class="flex-wrapper"><p>総<br>平均</p><div class="single-chart" style = "float:left;">';
      
            data +='<svg viewBox="0 0 36 36" class="circular-chart blue">';
            data +='<path class="circle-bg" d="M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831  a 15.9155 15.9155 0 0 1 0 -31.831" />';
            data +='<path class="circle" stroke-dasharray="'+new_progress+', 100" d="M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831  a 15.9155 15.9155 0 0 1 0 -31.831" />';
            data +='<text x="18" y="20.35" id="all_percentage" class="percentage">'+new_progress+'%</text></svg></div>';
             
             data += '<p>一週間の平均</p>';
             data += '<div class="single-chart" style = "float:left">';
             data +='<svg viewBox="0 0 36 36" class="circular-chart orange">';
             data +='<path class="circle-bg" d="M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831  a 15.9155 15.9155 0 0 1 0 -31.831" />';
             data +='<path class="circle" stroke-dasharray="'+avg_seven+', 100" d="M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831  a 15.9155 15.9155 0 0 1 0 -31.831" />';
             data +='<text x="18" y="20.35" id="seven_percentage" class="percentage">'+avg_seven+'%</text></svg></div>';
             
             data +='<p>パーセント</p>';
             data +='<div class="single-chart" id="insert_RT" style = "float:left">';
             
		
			data += '</div></div><br><div id="input_per" style="text-align:center;">';
			data += '<table style="width:100%;"><tr><td><input type="date" class="form-control" style="width:100%;" id="pro_date" "></td><td><input type="text" class="form-control" id="progress_per" style="width:100%;" placeholder="今日の達成率を入力してください。" onkeyup="insert_button(this)";></td>';
			data += '<td><input type="button" id="progress_button" value="登録" class="btn btn-outline-primary" style="width:100%;"></td></tr></table>';
			+'</div></div>';									

				$('#insert_process').html(data);
				$('#progress_button').click(insert_process_submit);		

				// (처음) insert부분만 그려주기
				insert_guri();
				//인서트에 숫자 넣으면 실시간 업뎃
				var test_per = $('#progress_per').val();
				
				$('#progress_per').on('keyup',table_insert_RT);					
			
		}
	
		//insert 맨 처음 그래프부분만 그려주기 && 숫자만 입력 (= 문자 입력안되게 )
		function insert_guri(){
			
			var data = '';
			data = '';
	        data +='<svg viewBox="0 0 36 36" class="circular-chart green">';
	        data +='<path class="circle-bg" d="M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831  a 15.9155 15.9155 0 0 1 0 -31.831" />';
	        data +='<path class="circle" id="insert_percentage_per" stroke-dasharray="'+0+', 100" d="M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831  a 15.9155 15.9155 0 0 1 0 -31.831" />';
	        data +='<text x="18" y="20.35" id="insert_percentage" class="percentage">'+0+'%</text></svg></div></div>';

			$('#insert_RT').html(data);
		
		}
		
		// insert부분 submit한거 값 실시간 전송 .....
		function table_insert_RT(event){
			
			var progress_per =$('#progress_per').val();
		
			event = event || window.event;
			var keyID = (event.which) ? event.which : event.keyCode;
			if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ){ 
			
			data = '';
	        data +='<svg viewBox="0 0 36 36" class="circular-chart green">';
	        data +='<path class="circle-bg" d="M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831  a 15.9155 15.9155 0 0 1 0 -31.831" />';
	        data +='<path class="circle" id="insert_percentage_per" stroke-dasharray="'+progress_per+', 100" d="M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831  a 15.9155 15.9155 0 0 1 0 -31.831" />';
	        data +='<text x="18" y="20.35" id="insert_percentage" class="percentage">'+progress_per+'%</text></svg></div></div>';
			
			$('#insert_RT').html(data);
			
			}else{
				return;
			}	
			
		}
		
		function removeChar(event) {
			event = event || window.event;
			var keyID = (event.which) ? event.which : event.keyCode;
			if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ){
				return;
			}else{
				event.target.value = event.target.value.replace(/[^0-9]/g, "");
			}
		}
						
		//insert 전송 버튼 (숫자) 전송
		function insert_button (){
			var progress_per =$('#progress_per').val();
			
			if(progress_per==''){
				progress_per=0;
			}
			
			$('#insert_percentage').html(progress_per+'%');	
		}		
	
		function insert_process_submit(){
			
			var progress_per = $('#progress_per').val(), pro_date = $('#pro_date').val();		
			//그래프에 달성률 넣긔.
			
			if(pro_date ==''){				
				alert("日付を入力してください。");
				return;
				
			}
			
			var data_ = {'progress_per':progress_per,
						'pro_date':pro_date};
			
			$.ajax({
				method:"GET",
				url : 'insert_progress',
				data : data_,
				success : function(resp){
					
					if(resp==1){
						all_list_avg_days_progress();
						 list_progress();
						 log_print();
						 
					}else{
						
						alert("もう一度お願いします。");
						return;
					}
				}
				
			});
		}
		
		function card_body_plus2(resp){
			
			var id = '';
			var data = '';
			var index =0;
				data += '<table>';
				data +='<tr><h3><i class="far fa-chart-bar" style="color:#4e73df;"></i>先週、各メンバーの進捗率</tr></h3><br>';
			member_number = resp.length;
			
			$('#team_num').html(member_number);
			
			$.each(resp,function(index,item){				
				data += '<tr><td style=" padding: 7px; width: 150px; text-align: center;">'+item.name+'</td><td style="width:130px;">'+item.department+'</td><td style=" padding:7px;width:500px; background-color:#F2F2F2" data-name="'+item.id+'" id="percent_body'+index+'"></tr>';
				$('#card_body_plus').html(data);			
			});
				data += '</table>';
				
				$('#login_success').click();
		}
	   
		function percent (resp){	
			
			var data = '';
			var member_number = resp.length;
			var id = '';		

			for (var i = 0; i < 5; i++) {					
					$.each(resp,function(index,item){
						
						id= $('#percent_body'+i).attr('data-name');
									
						if(id==item.id){												
								data = '<div class="progress"><div class="progress-bar progress-bar-striped" role="progressbar" style="width:'+item.progress_per+'%" aria-valuenow="20" readonly aria-valuemin="0" aria-valuemax="100" id="percent_body'+index+'" data-name ="'+item.id+'">'+item.progress_per+'%</div></div></td>';									
									$('#percent_body'+i).html(data);			 									
						}
					});
						}																	
		}		
		
		function delete_progress(){
			
			var progressNum = $(this).attr('data-sno'); 
			
			$.ajax({
				method : 'POST',
				url :'delete_progress',
				data : {'progressNum' : progressNum},
				success : function(aaa){				   
						 log_print();
						 all_list_avg_days_progress();
						 list_progress();					
				}
			});
			
			
		}
			
</script>
</head>

<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">

		<!-- Sidebar -->
		<ul
			class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion"
			id="accordionSidebar">

			<!-- Sidebar - Brand -->
			<a
				class="sidebar-brand d-flex align-items-center justify-content-center"
				href="#" style="cursor: auto;">
				<div class="sidebar-brand-icon rotate-n-15">
					<i class="far fa-laugh-squint"></i>
				</div>
				<div class="sidebar-brand-text mx-3" style="font-size: 20px;">チーム
					掲示板</div>
			</a>

			<!-- Divider -->
			<hr class="sidebar-divider my-0">

			<!-- Nav Item - Dashboard -->
			<li class="nav-item active"><a class="nav-link"
				href="goGroupBoard"> <i class="fas fa-book"></i> <span
					style="font-size: 15px;">掲示板
						ホーム(Team${sessionScope.groupBoardNum})</span></a></li>

			<!-- Divider -->
			<hr class="sidebar-divider">

			<!-- Heading -->
			<div class="sidebar-heading">MENU</div>

			<!-- Nav Item - Pages Collapse Menu -->
			<li class="nav-item" id="go_groupBoard">
        		<a class="nav-link collapsed" href="groupboard_list">
          		<i class="fas fa-fw fa-folder"></i>
          		<span>資料共有掲示板</span>
        		</a>
      		</li>

			<!-- Nav Item - Charts -->
			<li class="nav-item"><a class="nav-link" href="thesisWrite">
					<i class="fas fa-book-open"></i> <span>論文作成</span>
			</a></li>

			<!-- Nav Item - Tables -->
			<li class="nav-item"><a class="nav-link"
				href="goGroupBoardCalendar"> <i class="fas fa-calendar-alt"></i>
					<span>スケジュール</span></a></li>

			<!-- Divider -->
			<hr class="sidebar-divider d-none d-md-block">

		</ul>
		<!-- End of Sidebar -->

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">

				<!-- Topbar -->
				
					<!-- Content Row -->
					<div class="row" id="log_list_oo">
					</div>
				<nav
					class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
					<ul class="navbar-nav ml-auto">
					<li class="nav-item dropdown no-arrow mx-1">
							<div class="dropdown-toggle" data-toggle="dropdown"
								class="dropdown" id="chatForm">
								<a style="font-size: 25px; color: white;"> <i
									class="fas fa-comments" style="color: gray;"></i>
								</a>
							</div>
						</li>
						<li style="width:10px;"></li>
						<li class="nav-item dropdown no-arrow mx-1">
							<div class="dropdown" id="selectFiveMessages">
								<a class="dropdown-toggle" data-toggle="dropdown"
									style="font-size: 25px; color: white;"> <i
									class="fas fa-envelope" style="color: gray;"></i>
									<span class="badge badge-danger badge-counter" id="msgCount"></span>
								</a>
								<ul class="dropdown-menu dropdown-menu-right" role="menu"
									aria-labelledby="dLabel" id="menu">
									<li><div class="listOfMessage" style="width: 500px;"></div></li>
									<li>
									<div class="dropdown-content">
									<a
										class="dropdown-item text-center" href="viewAllMessages"
										style="text-align: center; font-size: 15px;">全てのメッセージを見る</a>
										</div>
										</li>
								</ul>
							</div>
						</li>
						<li class="nav-item dropdown no-arrow mx-1"><a href="../"
							style="font-size: 25px; color: white;"><i class="fas fa-home"
								style="color: gray;"></i></a></li>
						<div class="topbar-divider d-none d-sm-block"></div>
						<li class="nav-item dropdown no-arrow"><span
							class="mr-2 d-none d-lg-inline text-gray-600 small"
							style="font-size: 20px;">${sessionScope.loginName} 様</span></li>
					</ul>
				</nav>
				<!-- End of Topbar -->

				<!-- Begin Page Content -->
				<div class="container-fluid">

					<!-- Page Heading -->
					<div
						class="d-sm-flex align-items-center justify-content-between mb-4">

						<h1 class="h3 mb-0 text-gray-800" style="font-weight: bold;">Team${sessionScope.groupBoardNum}のプロジェクトの進捗率</h1>

					</div>
					</div>

					<!-- Content Rows -->

					<div class="row">

						<!-- Area Chart -->
					<div class="col-sm-7">
						<div class="col-xl-8 col-lg-7"  style="max-width: 100%;padding-left: 10px;">
						
							<div class="card shadow mb-4" id="plus_minus">
								<!-- Card Header - Dropdown -->
								<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
									<h6 class="m-0 font-weight-bold text-primary">チームの進捗率</h6>	
								</div>
								<!-- Card Body -->
								<div class="card-body" id="insert_process">
								</div>
								<div class="card-body" id="card_body_plus"></div>
								</div>
							
							
							<!-- Pie Chart -->
							
									<!-- Card Body -->
							
				</div>
				</div>
				<div class="col-sm-5">
						<div class="col-xl-8 col-lg-7"  style="max-width: 100%; height: 720px;">
						
							<div class="card shadow mb-4" id="plus_minus">
								<!-- Card Header - Dropdown -->
								<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
									<h6 class="m-0 font-weight-bold text-primary">進捗状況確認</h6>	
								</div>
							
					<div class="card-body" id="log_print" style="height: 600px; overflow: auto;">
							</div>
					</div>
					</div>
					</div>
					<!-- /.container-fluid -->

				</div>
				<!-- End of Main Content -->

				
	
				<!-- End of Footer -->

			</div>
			<!-- End of Content Wrapper -->
			
							
									</div>	
		</div>
		<!-- End of Page Wrapper -->

		<!-- Bootstrap core JavaScript-->
		<script
			src="<c:url value="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"/>"></script>

		<!-- Core plugin JavaScript-->
		<script
			src="<c:url value="/resources/vendor/jquery-easing/jquery.easing.min.js"/>"></script>

		<!-- Custom scripts for all pages-->
		<script src="<c:url value="/resources/js/sb-admin-2.min.js"/>"></script>
		<!-- Page level plugins -->
		<script
			src="${pageContext.request.contextPath}/resources/vendor/chart.js/Chart.min.js"></script>
		<!-- CKeditor4 -->
		<script
			src="${pageContext.request.contextPath}/resources/ckeditor/ckeditor.js"></script>
</body>

</html>
