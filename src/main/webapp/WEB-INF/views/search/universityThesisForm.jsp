<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>内方論文検索  Page</title>

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
	background-color: #3C85C4;
	color: white;
}

.btnDepart {
	display: none;
}

.btnYear {
	display: none;
}

.btnDegree {
	display: none;
}

th {
	text-align: center;
}
</style>
<script src="resources/js/jquery-3.3.1.js"></script>
<script>
	var selectDepart = "";
	var selectYear = "";
	var selectDegree = "";
	var onlysearch = [];
	
	$(function(){
		$(".department ").on('click', showDepartment);
	    $(".year ").on('click', showYear);
		$(".degree ").on('click', showDegree);
		$(".deleteDepart").on('click', deleteDepart);
		$(".deleteYear").on('click', deleteYear);
		$(".deleteDegree").on('click', deleteDegree);
		$("#searchUniversityThesis").on('click', searchUniversityThesis);
	});
	
	function deleteDepart(){
		$('.btnDepart').css('display', 'none');
		$('#department').text("");
		selectDepart = "";
	}
	
	function deleteYear(){
		$('.btnYear').css('display', 'none');
		$('#year').text("");
		selectYear = "";
	}
	
	function deleteDegree(){
		$('.btnDegree').css('display', 'none');
		$('#degree').text("");
		selectDegree = "";
	}
	
	function showDepartment(){
		var department = $(this).attr("data-val");
		var departmentName = $(this).text();
		
		$('#department').text(departmentName);
		$('.btnDepart').show();
		selectDepart = department;
	}
	
	function showYear(){
		var year = $(this).attr("data-val");
		var yearName = $(this).text();
		
		$('#year').text(yearName);
		$('.btnYear').show();
		selectYear = year;
	}
	
	function showDegree(){
		var degree = $(this).attr("data-val");
		var degreeName = $(this).text();
		
		$('#degree').text(degreeName);
		$('.btnDegree').show();
		selectDegree = degree;
	}
	
	function searchUniversityThesis(){
		if (selectDepart == "" && selectYear == "" && selectDegree == "") {
			alert("キーワードを選択してください。");
			return;
		}
		
		$.ajax({
			method : 'POST'
			, url : 'searchUniversityThesis'
			, data : {'department' : selectDepart
					   , 'year' : selectYear
					   , 'degree' : selectDegree}
			, success : function(resp) {
				outputThesis(resp);
			}
		});
	}
	
	function outputThesis(resp){
		var num = 1;
		var data   = '';
			  data += '<tr><th>番号</th><th>論文題目</th><th>著者</th><th>発行日</th>';
			  if(resp == ""){
				  data +=  '<tr><td colspan="4" style="text-align:center;">キーワードと合う論文がありません。</td></tr>';
			  } else {
				  $.each(resp, function(index, item){
				  		data += '<tr id="'+ item.thesisSeq +'">';
				  		data += '<td class="thesisSeq" style="text-align : center; vertical-align:middle; width:80px;">'+num+'</td>';
				  		data += '<td class="thesisTitle" style="vertical-align:middle; width:800px;"><a href="searchThesisDetail?thesisSeq='+item.thesisSeq+'">'+item.thesisTitle+'</a></td>';
				  		data += '<td class="thesisAuthor" style="text-align : center; vertical-align:middle;">'+item.thesisAuthor+'</td>';
				  		data += '<td class="thesisDate" style="text-align : center; vertical-align:middle; width:150px;">'+item.thesisDate+'</td>';
				  		data += '</tr>'
				  		num++;
			 	 });
			  }
		$("#dataTable").html(data);
	}
	
</script>
</head>

<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">

		<!-- Sidebar -->
		<ul
			class="navbar-nav bg-gradient-danger sidebar sidebar-dark accordion"
			id="accordionSidebar">

			<!-- Sidebar - Brand -->
			<a
				class="sidebar-brand d-flex align-items-center justify-content-center"
				href="#">
					<i class="fas fa-torah fa-2x"></i>
				<div class="sidebar-brand-text mx-3">
					<span style="font-size: 25px;">論文検索</span>
				</div>
			</a>

			<!-- Divider -->
			<hr class="sidebar-divider my-0">

			<!-- Nav Item - Dashboard -->
			<li class="nav-item active"><a class="nav-link"
				href="goUniversityThesisForm"><i class="fas fa-school"></i> <span>検索ホーム</span></a>
			</li>

			<!-- Divider -->
			<hr class="sidebar-divider">

			<!-- Heading -->
			<div class="sidebar-heading">キーワード</div>

			<li class="nav-item"><a class="nav-link collapsed" href="#"
				data-toggle="collapse" data-target="#collapseTwo"
				aria-expanded="true" aria-controls="collapseTwo"> <i class="fas fa-pen-fancy"></i> <span>学科</span>
			</a>
				<div id="collapseTwo" class="collapse" aria-labelledby="headingTwo"
					data-parent="#accordionSidebar">
					<div class="bg-white py-2 collapse-inner rounded">
						<button class="department dropdown-item" type="button" data-val="medical">医学系研究科</button>
					 	<button class="department dropdown-item" type="button" data-val="education">教育学研究科</button>
						<button class="department dropdown-item" type="button" data-val="economy">経済学研究科</button>
						<button class="department dropdown-item" type="button" data-val="engineering">工学系研究科</button>
					 	<button class="department dropdown-item" type="button" data-val="information">情報理工学系研究科</button>
						<button class="department dropdown-item" type="button" data-val="frontier science">新領域創成科学研究科</button>
						<button class="department dropdown-item" type="button" data-val="humanities">人文社会系研究科</button>
					 	<button class="department dropdown-item" type="button" data-val="mathematics">数理科学研究科</button>
						<button class="department dropdown-item" type="button" data-val="culture">総合文化研究科</button>
						<button class="department dropdown-item" type="button" data-val="agriculture">農学生命科学研究科</button>
						<button class="department dropdown-item" type="button" data-val="law">法学政治学研究科</button>
					 	<button class="department dropdown-item" type="button" data-val="pharmacy">薬学系研究科</button>
						<button class="department dropdown-item" type="button" data-val="sciences">理学系研究科</button>
					</div>
				</div></li>

			<li class="nav-item"><a class="nav-link collapsed" href="#"
				data-toggle="collapse" data-target="#collapseUtilities"
				aria-expanded="true" aria-controls="collapseUtilities"> 
				<i class="fas fa-book"></i> <span>年度</span>
			</a>
				<div id="collapseUtilities" class="collapse"
					aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
					<div class="bg-white py-2 collapse-inner rounded">
						<button class="year dropdown-item" type="button" data-val="2014 ~">2014 ~</button>
						<button class="year dropdown-item" type="button" data-val="2008 ~ 2013">2008 ~ 2013</button>
						<button class="year dropdown-item" type="button" data-val="2002 ~ 2007">2002 ~ 2007</button>
					 	<button class="year dropdown-item" type="button" data-val="1997 ~ 2001">1997 ~ 2001</button>
						<button class="year dropdown-item" type="button" data-val="~ 1996">~ 1996</button>
					</div>
				</div></li>
				
			<li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages" aria-expanded="true" aria-controls="collapsePages">
         <i class="fas fa-graduation-cap"></i>
          <span>学位</span>
        </a>
        <div id="collapsePages" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
          		<button class="degree dropdown-item" type="button" data-val="graduate">学士</button>
				<button class="degree dropdown-item" type="button" data-val="master">修士</button>
				<button class="degree dropdown-item" type="button" data-val="doctor">博士</button>
				<button class="degree dropdown-item" type="button" data-val="other">その他</button>
            <div class="collapse-divider"></div>           
          </div>
        </div>
      </li>
			<hr class="sidebar-divider">
		</ul>
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">

				<!-- Topbar -->
				<nav
					class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
					<ul class="navbar-nav ml-auto">
						<li class="nav-item dropdown no-arrow mx-1"><a href="../"
							style="font-size: 25px; color: white;"><i class="fas fa-home"
								style="color: gray;"></i></a></li>
						<div class="topbar-divider d-none d-sm-block"></div>
						<li class="nav-item dropdown no-arrow"><span
							class="mr-2 d-none d-lg-inline text-gray-600 small"
							style="font-size: 20px;">${sessionScope.loginName} 様</span></li>

					</ul>
				</nav>

				<div class="container-fluid">

					<div class="d-sm-flex align-items-center justify-content-between mb-4" style="height: 80px;">
            <h1 class="h3 mb-0 text-gray-800">選択したキーワード
            	<div>
						<div style="height: 10px;"></div>
            			<div class="btnDepart" style="float:left; padding-right: 10px;"><button type="button" class="btn btn-outline-danger"><span id="department"></span> <i class="deleteDepart fas fa-times"></i></button></div>
						<div class="btnYear" style="float:left; padding-right: 10px;"><button type="button" class="btn btn-outline-danger"><span id="year"></span> <i class="deleteYear fas fa-times"></i></button></div>
						<div class="btnDegree" style="float:left; padding-right: 10px;"><button type="button" class="btn btn-outline-danger"><span id="degree"></span> <i class="deleteDegree fas fa-times"></i></button></div>
            	</div>
            	</h1>
             <button class="btn btn-danger" id="searchUniversityThesis"><i class="fas fa-search fa-sm text-white-50"></i> 論文検索</button>
			          </div>
					<hr class="sidebar-divider d-none d-md-block">

						<div class="card shadow mb-4">
            <div class="card-header py-3">
              <h4 class="m-0 font-weight-bold text-danger">お探しの論文</h4>
            </div>
            <div class="card-body">
              <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                	<tr>
                		<td style="text-align: center; font-size: 25px;">論文を検索してください。</td>
                	</tr>
                </table>
              </div>
            </div>

        </div>
					</div>

				</div>

				<script src="resources/vendor/jquery/jquery.min.js"></script>
				<script src="resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
				<script src="resources/vendor/jquery-easing/jquery.easing.min.js"></script>
				<script src="resources/js/sb-admin-2.min.js"></script>
				<script src="resources/vendor/datatables/jquery.dataTables.min.js"></script>
</body>

</html>
