<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>内方論文検索 Page</title>

<link
	href="${pageContext.request.contextPath}/resources/vendor/datatables/dataTables.bootstrap4.min.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=M+PLUS+Rounded+1c:400,500,700&amp;subset=japanese"
	rel="stylesheet" type='text/css'>
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

th {
	text-align: center;
}

#text {
	font-size: 8px;
	text-align: center;
}

#comment_list_div {
	text-align: center;
}

.dropdown {
	float: right;
}

.link {
	float: right;
}

li {
	color: black;
}

.dropdown-content a:hover {
	background-color: #3C85C4;
	color: white;
}
</style>

<script src="resources/js/jquery-3.3.1.js"></script>
<script src="resources/ckeditor/ckeditor.js"></script>
<script>

</script>
</head>

<body id="page-top">

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
					<div class="card shadow mb-4">
						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered" id="dataTable" width="100%"
									cellspacing="0">
									<tr style="font-size: 30px;">
										<th colspan="2" style="text-align: left;">${Thesis.thesisTitle}</th>
									</tr>
									<tr>
										<th style="width: 200px;">著者</th>
										<td>${Thesis.thesisAuthor} </td>
									</tr>
									<tr>
										<th>発行日</th>
										<td>${Thesis.thesisDate}</td>
									</tr>
									<tr>
										<th>添付ファイル</th>
										<td><c:if test="${Thesis.thesisLink != null}">
												<a href="${Thesis.thesisLink}" target="_blank">
													${Thesis.thesisLink}</a>
											</c:if>
											<c:if test="${Thesis.thesisSavename != null}">
												<a href="thesisDownload?thesisSeq=${Thesis.thesisSeq}">
												${Thesis.thesisOrgname}</a>
											</c:if>	
										</td>
									</tr>
									<tr>
										<th>抄録</th>
										<td>${Thesis.thesisAbstract}</td>
									</tr>
										<tr style="text-align: right;">
											<td colspan="2"><a class="btn btn-danger"
												href="goUniversityThesisForm" role="button"> <i
													class="fas fa-undo-alt"></i> 戻る
											</a></td>
										</tr>
								</table>
							</div>
						</div>
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