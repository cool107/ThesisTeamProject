<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!doctype html>
<html>
<head lang="en">
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">

<title>論文検索選択 Page</title>
<meta name="description"
	content="BlackTie.co - Free Handsome Bootstrap Themes" />
<meta name="keywords"
	content="themes, bootstrap, free, templates, bootstrap 3, freebie,">
<meta property="og:title" content="">

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/style.css">
<link
	href="https://fonts.googleapis.com/css?family=M+PLUS+Rounded+1c:400,500,700&amp;subset=japanese"
	rel="stylesheet" type='text/css'>
<!-- 쪽지 아이콘 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="${pageContext.request.contextPath}/resources/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<style>
body {
	background-image: url('resources/images/bg1.jpg');
	background-size: 100%;
	color: white;
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

.badge-counter {
    transform: scale(.9);
    transform-origin: top right;
    right: 1em;
    top: -0.3em;
    margin-top: -.25rem;
    background-color: red;
}
</style>
<script src="<c:url value="/resources/js/html5shiv.js"/>"></script>
<script src="<c:url value="/resources/js/jquery-1.10.2.min.js"/>"></script>
<script src="<c:url value="/resources/js/jquery-migrate-1.2.1.min.js"/>"></script>
<script src="<c:url value="/resources/js/bootstrap.min.js"/>"></script>
<script src="<c:url value="/resources/js/jquery.easing.1.3.js"/>"></script>
<script src="<c:url value="/resources/js/jquery-3.3.1.js"/>"></script>
<script>
	$(function() {
		selectMsgCount();
		$('#selectFiveMessages').on('click', selectFive);
		$('#goSearchForm').on('click', goSearchForm);
		$('#goUniversityThesisForm').on('click', goUniversityThesisForm);
		//5개 뽑아오기
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

		function outputMsg(resp) {

			var content = '<table class="table table-bordered" id="msgTable" cellspacing="0" style="table-layout:fixed;">';
			if (resp == "") {
				content += '<p style="text-align:center; font-weight: bold; font-size:25px; color:#1cc88a;"><i class="fas fa-dove fa-lg" style="color:#1cc88a;"></i> ${sessionScope.loginName}様のメッセージ</p>';
				content += '<tr style="text-align:center; font-size:15px;"><td colspan="2">新しいメッセージがありません。</td></tr>';
			}
			if (resp != "") {
				content += '<p style="text-align:center; font-weight: bold; font-size:25px; color:#1cc88a;"><i class="fas fa-dove fa-lg" style="color:#1cc88a;"></i> ${sessionScope.loginName}様のメッセージ</p>';
				$
						.each(
								resp,
								function(index, item) {
									content += '<tr>';
									content += '<td class="fromId" style="width:80px;">'
											+ item.fromId + '</td>';
									content += '<td class="messageContent" style="text-overflow:ellipsis; overflow:hidden; white-space:nowrap;">'
											+ '<a href = "entergetMsg?msg_seq='
											+ item.msg_seq
											+ '" id = "getMessage">'
											+ item.messageContent
											+ '</a>'
											+ '</td>';
									content += '<td class="messageIndate" style="width:150px;">'
											+ item.messageIndate + '</td>';
									content += '</tr>';
								});
			}
			content += '</table>';

			$('.listOfMessage').html(content);
		}
		;

		function goUniversityThesisForm() {
			location.href = "/goUniversityThesisForm";
		}
		
		function goSearchForm() {
			location.href = "/goSearchForm";
		};
	});
</script>
</head>

<body>
	<div class="navbar navbar-fixed-top">
		<c:if test="${sessionScope.loginId != null }">
			<!-- 로그인후 -->

			<div class="link">
				<p style="text-align: right; font-size: 20px;">
					&nbsp;&nbsp;&nbsp;&nbsp; <a class="nav-link active"
						href="logoutMember">LOGOUT</a> &nbsp;&nbsp;
					<c:if test="${sessionScope.loginDivision == '学生'}">
				&nbsp;&nbsp;
				<a class="nav-link" href="mypage">MYPAGE</a>
				&nbsp;&nbsp;&nbsp;&nbsp;
				<a class="nav-link" href="../">HOME</a>
				&nbsp;&nbsp;
					</c:if>
				</p>
			</div>
			<c:if test="${sessionScope.loginDivision == '学生'}">
				<div class="dropdown" id="selectFiveMessages">

					<a class="dropdown-toggle" data-toggle="dropdown"> <img
						src="https://img.icons8.com/ultraviolet/40/000000/new-post.png"
						width="30px" height="30px" />
						<span class="badge badge-danger badge-counter" id="msgCount"></span>
					</a>
					<c:if test="${sessionScope.loginGroupBoardNum != 0}">
						<ul class="dropdown-menu pull-right" role="menu"
							aria-labelledby="dLabel" id="menu">
							<li><div class="listOfMessage" style="width: 500px;"></div></li>
							<li><div class="dropdown-divider"></div> <a
								class="viewAllMessages" href="viewAllMessages"
								style="text-align: center; font-size: 15px;">全てのメッセージを見る</a></li>
						</ul>
					</c:if>
					<c:if test="${sessionScope.loginGroupBoardNum == 0}">
						<ul class="dropdown-menu dropdown-menu-right" role="menu"
							aria-labelledby="dLabel" id="menu">
							<li><div class="listOfMessage" style="width: 500px;"></div></li>
							<li><div class="dropdown-divider"></div> <a
								class="viewAllMessages" href="viewAllMessages"
								style="text-align: center; font-size: 15px;">全てのメッセージを見る</a></li>
						</ul>
					</c:if>
				</div>
			</c:if>
		</c:if>
	</div>
	<!-- /.navbar -->


	<!-- === MAIN Background === -->
	<div class="slide story" id="slide-1">
		<div class="container">
			<div id="home-row-1" class="row clearfix">
				<div class="col-12">
					<h1 class="font-thin">
						見たい論文を <span class="font-semibold" style="font-size: 80px;">選択</span> してください。
					</h1>
					<c:if test="${sessionScope.loginId != null }">
					</c:if>
					<br> <br>
				</div>
			</div>
			<c:if
				test="${sessionScope.loginId != null && sessionScope.loginDivision == '学生'}">
				<div id="home-row-2" class="row clearfix">
					<div class="col-12 col-sm-6">
						<div class="home-hover navigation-slide">
						<div id="goSearchForm">
							<i class="fas fa-sign-out-alt fa-5x"></i>
						</div>
						</div>
						<span>外方論文検索</span>
					</div>
					<div class="col-12 col-sm-6">
						<div class="home-hover navigation-slide">
							<div id="goUniversityThesisForm">
								<i class="fas fa-sign-in-alt fa-5x"></i>
							</div>
						</div>
						<span>内方論文検索
						</span>
					</div>
				</div>
			</c:if>
		</div>
	</div>

</body>

</html>