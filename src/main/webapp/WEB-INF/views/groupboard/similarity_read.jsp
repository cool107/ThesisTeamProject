<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html lang="en">
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

<title>全体 掲示板 Page</title>

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
</style>
<script src="resources/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
	$(function() {
		$("#go_groupBoard").on('click', go_groupBoard);
		$("#detail").on('click', detail);
		$("#detail_search").on('click', detail_search);

	});
	
	function link() {
		var address=$(this).data-val();
    	var settings = 'width=600, height=615, resizable = no, scrollbars = no';
		window.open('${result.link}',settings);
	}
	
	function go_groupBoard() {
		location.href = "groupboard_list";
	}
	
	function detail() {
		window.open('${result.link}');
    }
	
	function detail_search() {
		window.open('${listforsearch.link}');
    }

</script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판</title>

</head>
<body id="page-top">

  <!-- Page Wrapper -->
  <div id="wrapper">

    <!-- Sidebar -->
    <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

      <!-- Sidebar - Brand -->
      <a class="sidebar-brand d-flex align-items-center justify-content-center" style="cursor: auto;">
        <div class="sidebar-brand-icon rotate-n-15">
          <i class="far fa-laugh-squint"></i>
        </div>
        <div class="sidebar-brand-text mx-3" style="font-size: 20px;">チーム 掲示板</div>
      </a>


      <!-- Divider -->
      <hr class="sidebar-divider my-0">

      <!-- Nav Item - Dashboard -->
      <li class="nav-item active">
        <a class="nav-link" href="#">
          <i class="fas fa-book"></i>
          <span style="font-size: 15px;">掲示板 ホーム(Team${sessionScope.groupBoardNum})</span></a>
      </li>

      <!-- Divider -->
      <hr class="sidebar-divider">

      <!-- Heading -->
      <div class="sidebar-heading">
        MENU
      </div>

      <!-- Nav Item - Pages Collapse Menu -->
      <li class="nav-item" id="go_groupBoard">
        <a class="nav-link collapsed" href="groupboard_list">
          <i class="fas fa-fw fa-folder"></i>
          <span>資料共有掲示板</span>
        </a>
      </li>

      <!-- Nav Item - Charts -->
      <li class="nav-item">
        <a class="nav-link" href="thesisWrite">
          <i class="fas fa-book-open"></i>
          <span>論文作成</span></a>
      </li>

      <!-- Nav Item - Tables -->
      <li class="nav-item">
        <a class="nav-link" href="goGroupBoardCalendar">
          <i class="fas fa-calendar-alt"></i>
          <span>スケジュール</span></a>
      </li>

      <!-- Divider -->
      <hr class="sidebar-divider d-none d-md-block">

      <!-- Sidebar Toggler (Sidebar) -->
      <div class="text-center d-none d-md-inline">
        <button class="rounded-circle border-0" id="sidebarToggle"></button>
      </div>

    </ul>
    <!-- End of Sidebar -->

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

      <!-- Main Content -->
      <div id="content">

        <!-- Topbar -->
        <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

          <!-- Sidebar Toggle (Topbar) -->
          <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
            <i class="fa fa-bars"></i>
          </button>


          <!-- Topbar Navbar -->
          <ul class="navbar-nav ml-auto">

            <!-- Nav Item - Search Dropdown (Visible Only XS) -->
            <li class="nav-item dropdown no-arrow d-sm-none">
              <a class="nav-link dropdown-toggle" href="#" id="searchDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <i class="fas fa-search fa-fw"></i>
              </a>
              <!-- Dropdown - Messages -->
              <div class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in" aria-labelledby="searchDropdown">
                <form class="form-inline mr-auto w-100 navbar-search">
                  <div class="input-group">
                    <input type="text" class="form-control bg-light border-0 small" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2">
                    <div class="input-group-append">
                      <button class="btn btn-primary" type="button">
                        <i class="fas fa-search fa-sm"></i>
                      </button>
                    </div>
                  </div>
                </form>
              </div>
            </li>
            <li class="nav-item dropdown no-arrow mx-1"><a href="#"
							style="font-size: 25px; color: white;"><i class="fas fa-envelope"
								style="color: gray;"></i></a>&nbsp;&nbsp;</li>
           <li class="nav-item dropdown no-arrow mx-1"><a href="../"
							style="font-size: 25px; color: white;"><i class="fas fa-home"
								style="color: gray;"></i></a></li>
						<div class="topbar-divider d-none d-sm-block"></div>
						<li class="nav-item dropdown no-arrow"><span
							class="mr-2 d-none d-lg-inline text-gray-600 small"
							style="font-size: 20px;">${sessionScope.loginName} 様</span></li>
    
              	</i>
              </a>   
    			
            </li>

          </ul>

        </nav>
        <!-- End of Topbar -->

				<hr class="sidebar-divider d-none d-md-block">

				<div class="container-fluid">

					<div class="card shadow mb-4">
						<div class="card-body">
							<div class="table-responsive" id="editor1">
								<table class="table table-bordered" id="dataTable" width="100%"
									cellspacing="0">
									<c:if test="${listforsearch==null}">
									<tr>
										<th style="width: 200px;">文題</th>
										<td>${result.searchedTitle}</td>
									</tr>
									<tr>
										<th style="width: 200px;">検索語</th>
										<td>${result.searchTitle}</td>
									</tr>
									<tr>
										<th>著者</th>
										<td>${result.author}</td>
									</tr>
									<tr>
										<th>発行日</th>
										<td>${result.publishedDate}</td>
									</tr>
									<tr>
										<th>検索語</th>	
										<td>
										<c:if test="${result.similarity==0.00}">
								                          <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">0%</div>
								                        </div>
								                        <div class="col">
								                          <div class="progress progress-sm mr-2">
								                            <div class="progress-bar bg-info" role="progressbar" style="width: ${result.similarity}%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
								                          </div>
								                        </div>
								                      </div>
								                        </c:if>
										<c:if test="${result.similarity<30&&result.similarity>0}">
								                          <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800"><fmt:formatNumber value="${result.similarity}" pattern=".00"/>
								                          %</div>
								                        </div>
								                        <div class="col">
								                          <div class="progress progress-sm mr-2">
								                            <div class="progress-bar bg-info" role="progressbar" style="width: ${result.similarity}%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
								                          </div>
								                        </div>
								                      </div>
								                        </c:if>
								                        <c:if test="${result.similarity>=50&&result.similarity<85}">
								                          <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800" "><fmt:formatNumber value="${result.similarity}" pattern=".00"/>
								                          %</div>
								                        </div>
								                        <div class="col">
								                          <div class="progress progress-sm mr-2">
								                            <div class="progress-bar bg-info" role="progressbar" style="width: ${result.similarity}; background-color:yellowimportant;" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
								                          </div>
								                        </div>
								                      </div>
								                        </c:if>
								                        <c:if test="${result.similarity>=85&&result.similarity<100}">
								                          <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800" ><fmt:formatNumber value="${result.similarity}" pattern=".00"/>
								                          %</div>
								                        </div>
								                        <div class="col">
								                          <div class="progress progress-sm mr-2">
								                            <div class="progress-bar bg-info" role="progressbar" style="width: ${result.similarity}%; background-color:red !important;" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
								                          </div>
								                        </div>
								                      </div> 
								                        </c:if>
								                        <c:if test="${result.similarity==100.00}">
								                          <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800" >100%</div>
								                        </div>
								                        <div class="col">
								                          <div class="progress progress-sm mr-2">
								                            <div class="progress-bar bg-info" role="progressbar" style="width: ${result.similarity}%; background-color:red !important;" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
								                          </div>
								                        </div>
								                      </div> 
								                        </c:if>
								                        </td>
									</tr>
									<tr>
										<th>抄錄</th>
										<td colspan="2" style="text-align: left;">${result.searchedAbstract}</th>
									</tr>
									
									<tr>
										<th>私が書いた 抄錄</th>
										<td colspan="2" style="text-align: left;">${result.searchAbstract}</th>
									</tr>
									
									<tr>
										<th style="width: 200px;">詳細表示</th>
										<td style="color: blue; cursor: pointer;" id="detail">${result.link}</td>
									</tr>
									<tr style="text-align: right;">
											<td colspan="2">
												<a class="back btn btn-info" href="javascript:history.back();" role="button">
												<i class="fas fa-undo-alt"></i>  戻る</a>	
											</td>
										</tr>
										</c:if>
										<c:if test="${listforsearch!=null}">
										<tr>
										<th style="width: 200px;">文題</th>
										<td>${listforsearch.searchedTitle}</td>
									</tr>
									<tr>
										<th style="width: 200px;">検索語</th>
										<td>${listforsearch.searchTitle}</td>
									</tr>
									<tr>
										<th>著者</th>
										<td>${listforsearch.author}</td>
									</tr>
									<tr>
										<th>発行日</th>
										<td>${listforsearch.publishedDate}</td>
									</tr>
									<tr>
									<tr>
										<th>抄錄</th>
										<td colspan="2" style="text-align: left;">${listforsearch.searchedAbstract}</th>
									</tr>
									<tr>
										<th style="width: 200px;">詳細表示</th>
										<td style="color: blue; cursor: pointer;" id="detail_search" class="detail" data-val="${listforsearch.link}">${listforsearch.link}</td>
									</tr>
									<tr style="text-align: right;">
											<td colspan="2">
												<a class="back btn btn-info" href="javascript:history.back();" role="button">
												<i class="fas fa-undo-alt"></i>  戻る</a>	
											</td>
										</tr>
										</c:if>
										
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