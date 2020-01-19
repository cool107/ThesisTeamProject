<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>チーム 掲示板</title>

  <!-- Custom fonts for this template-->
  <link href="${pageContext.request.contextPath}/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link
		href="https://fonts.googleapis.com/css?family=M+PLUS+Rounded+1c:400,500,700&amp;subset=japanese"
		rel="stylesheet" type='text/css'>

  <!-- Custom styles for this template-->
  <link href="${pageContext.request.contextPath}/resources/css/sb-admin-2.min.css" rel="stylesheet">
<style>
	body {
		font-family: 'M PLUS Rounded 1c', sans-serif;
	}
	
	button {
		font-family: 'M PLUS Rounded 1c', sans-serif;
	}
	
	.yellow {
    background-color: yellow;
	}
	
	.red {
    background-color: red;
	}
	
	
	</style>
  <script src="${pageContext.request.contextPath}/resources/vendor/jquery/jquery.min.js"></script>
	<script>
	    $(function() {
			$(".readBoard").on('click', go_groupBoard);
			$('.similarityRead').on('click', go_read)
			$('.searchRead').on('click', go_readforsearch)
		});
		
	    function go_readforsearch() {
			var link=$(this).attr('data-val');
			location.href = "search_read?link="+link;
		}
	    
		function go_read() {
			var issn=$(this).attr('data-val');
			location.href = "similarity_read?issn="+issn;
		}
		
	    
	</script>
</head>

<body id="page-top">

  <!-- Page Wrapper -->
  <div id="wrapper">

    <!-- Sidebar -->
    <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

      <!-- Sidebar - Brand -->
      <a class="sidebar-brand d-flex align-items-center justify-content-center" href="index.html">
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

        <!-- Begin Page Content -->
        <div class="container-fluid">

          <!-- Page Heading -->
          <div class="d-sm-flex align-items-center justify-content-between mb-4">
          <c:if test="${listforsearch==null}">
            <h1 class="h3 mb-0 text-gray-800">類似度検査結果</h1>
            </c:if>
            <c:if test="${listforsearch!=null}">
            <h1 class="h3 mb-0 text-gray-800">検索結果</h1>
            </c:if>
            <a href="javascript:history.back();" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i class="fas fa-undo-alt"></i> 跡取り</a>
          </div>

          <!-- Content Row -->
          <c:if test="${listforsearch==null}">
          <div class="row">

            <!-- Tasks Card Example -->
            <td><div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-info shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-info text-uppercase mb-1" style="font-size: 15px;">下</div>
                      <div class="row no-gutters align-items-center">
                        <div class="col-auto">
                          <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">30%</div>
                        </div>
                        <div class="col">
                          <div class="progress progress-sm mr-2">
                            <div class="progress-bar bg-info"  role="progressbar" style="width: 30%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100" ></div>
                          </div>
                        </div>
                      </div>
                    </div>
                   </div>
                  </div>
                </div>
              </div></td>
              <td><div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-info shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-info text-uppercase mb-1"style="font-size: 15px;">中</div>
                      <div class="row no-gutters align-items-center">
                        <div class="col-auto">
                          <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">60%</div>
                        </div>
                        <div class="col">
                          <div class="progress progress-sm mr-2">
                            <div class="red progress-bar" role="progressbar" id="red" style="width: 60%; background-color:yellow;" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100" ></div>
                          </div>
                        </div>
                      </div>
                    </div>
                   </div>
                  </div>
                </div>
              </div></td>
              <td><div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-info shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-info text-uppercase mb-1"style="font-size: 15px;">上</div>
                      <div class="row no-gutters align-items-center">
                        <div class="col-auto">
                          <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">80%</div>
                        </div>
                        <div class="col">
                          <div class="progress progress-sm mr-2">
                            <div class="progress-bar" role="progressbar" id="red" style="width: 80%; background-color:red;" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100" ></div>
                          </div>
                        </div>
                      </div>
                    </div>
                   </div>
                  </div>
                </div>
              </div></td>
            </div>
			</c:if>
            <!-- Pending Requests Card Example -->
            <hr class="sidebar-divider d-none d-md-block">

						<div class="card shadow mb-4">
							<div class="card-body">
								<div class="table-responsive" id="editor1">
									<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
											<c:if test="${listforsearch==null}">
											<tr>
												<th style="width:50%;">類似性</th>
												<th style="width:30%">論文文題</th>
												<th style="width:20%">著者</th>
											</tr>
											</c:if>
											<c:if test="${listforsearch!=null}">
											<tr>
												<th style="width:80%">論文文題</th>
												<th style="width:20%">著者</th>
											</tr>
											</c:if>
											<c:if test="${listforsearch==null}">
											<c:forEach var="result" items="${resultList}" varStatus="status">
												<tr>
													<td>
													<c:if test="${result.similarity==0.00}">
													<div class="row no-gutters align-items-center">
													<div class="col-auto">
								                          <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">0%</div>
								                        </div>
								                        <div class="col">
								                          <div class="progress progress-sm mr-2">
								                            <div class="progress-bar bg-info" role="progressbar" style="width: ${result.similarity}% " aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
								                          </div>
								                        </div>
								                      </div></td>
								                        </c:if>
													<c:if test="${result.similarity<30.00&&result.similarity>0.00}">
													
													<div class="row no-gutters align-items-center">
													<div class="col-auto">
								                          <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800"><fmt:formatNumber value="${result.similarity}" pattern=".00"/>
								                          %</div>
								                        </div>
								                        <div class="col">
								                          <div class="progress progress-sm mr-2">
								                            <div class="progress-bar bg-info" role="progressbar" style="width: ${result.similarity}% " aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
								                          </div>
								                        </div>
								                      </div></td>
								                        </c:if>
								                        <c:if test="${result.similarity>=30.00&&result.similarity<85.00}">
								                        <div class="row no-gutters align-items-center">
														<div class="col-auto">
								                          <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800" "><fmt:formatNumber value="${result.similarity}" pattern=".00"/>
								                          %</div>
								                        </div>
								                        <div class="col">
								                          <div class="progress progress-sm mr-2">
								                            <div class="yellow progress-bar bg-info" role="progressbar" id="yellow" style="width:${result.similarity}%; background-color:yellow !important;" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
								                          </div>
								                        </div>
								                      </div></td>
								                        </c:if>
								                        <c:if test="${result.similarity>=85.00&&result.similarity<100.00}">
								                        <div class="row no-gutters align-items-center">
														<div class="col-auto">
								                          <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800" ><fmt:formatNumber value="${result.similarity}" pattern=".00"/>
								                          %</div>
								                        </div>
								                        <div class="col">
								                          <div class="progress progress-sm mr-2">
								                            <div class="red progress-bar bg-info" role="progressbar" id="red" style="width:${result.similarity}%;background-color:red !important;" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
								                          </div>
								                        </div>
								                      </div> </td>
								                        
								                        </c:if>
								                        <c:if test="${result.similarity==100.00}">
								                        <div class="row no-gutters align-items-center">
														<div class="col-auto">
								                          <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800" >100%</div>
								                        </div>
								                        <div class="col">
								                          <div class="progress progress-sm mr-2">
								                            <div class="red progress-bar bg-info" role="progressbar" id="red" style="width:${result.similarity}%;background-color:red !important;" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
								                          </div>
								                        </div>
								                      </div> </td>
								                        
								                        </c:if>
													<td style="color: blue;">
													<div class="similarityRead" style="color: blue; cursor: pointer;" id="similarityRead" data-val="${result.issn}">
													${result.searchedTitle}</a>
													</div>										
													</td>
													<td>
													<div class="groupboardRead" id="author" data-val="${result.similarity}">
													${result.author}</a>
													</div>										
													</td>
												</tr>			
											</c:forEach>
											</c:if>
											<c:if test="${listforsearch!=null}">
											<c:forEach var="result" items="${listforsearch}" varStatus="status">
													<td style="color: blue;">
													<div class="searchRead" style="color: blue; cursor: pointer;" data-val="${result.link}">
													${result.searchedTitle}</a>
													</div>										
													</td>
													<td>
													<div id="author" data-val="${result.similarity}">
													${result.author}</a>
													</div>										
													</td>
												</tr>
												</c:forEach>
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