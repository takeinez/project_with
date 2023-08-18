<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("id");
	String pw = request.getParameter("pw"); 
	String name = request.getParameter("name"); 
	String job = request.getParameter("job");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>WITH-대한민국zi존협업툴</title>
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
	<link href='http://fonts.googleapis.com/css?family=Roboto:400,300,100,500,700' rel='stylesheet' type='text/css'>
	<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/font-applesdgothicneo@1.0/all.min.css">
	<script src="https://kit.fontawesome.com/42669b0565.js" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
	
	<style>
		::-webkit-scrollbar {
	    width: 7px;
	    height: 7px;
	    padding-right: 10px;
		}
		::-webkit-scrollbar-button {
	    width: 7px;
	    height: 7px;
		}
		::-webkit-scrollbar-corner {
	    background: 0 0;
		}
		::-webkit-scrollbar-thumb {
	    background: #999;
	    border: 1px solid #999;
	    -webkit-border-radius: 50px;
	    border-radius: 50px;
		}
		::-webkit-scrollbar-track {
	    background: 0 0;
	    border: 0 none transparent;
	    -webkit-border-radius: 53px;
	    border-radius: 53px;
		}
		html {
	    -webkit-text-size-adjust: 100%;
		}
		body {
		font-family: "Noto Sans KR",Roboto,"Malgun Gothic","맑은 고딕",helvetica,
		"Apple SD Gothic Neo",sans-serif,"Apple Color Emoji","Twemoji Country Flags";
		color: #333;
    	line-height: 1;
    	letter-spacing: -.02em;
    	background:#fff; 
    	margin-top: 0;
	    margin-right: 0;
	    margin-bottom: 0;
	    margin-left: 0;
		}
		article, aside, figcaption, figure, footer, header, nav, section {
    	display: block;
		}
		
		* {
		box-sizing: border-box;
		}
		.with-header{
		position: fixed;
	    top: 0;
	    left: 0;
	    width: 100%;
	    background: 0 0;
	    z-index: 9;
	    display:sticky;
		}
		a{
		margin: 0;
		padding: 0;
    	font-size: inherit;
		text-decoration: none;
	    vertical-align: baseline;
	    color: inherit;
    	background: 0 0;
	    cursor: pointer;
		}
		
		.top-thin-banner{
		display: flex;
	    width: 100%;
	    height: 50px;
	    position: fixed;
	    top: 0;
	    left: 0;
	    align-items: center;
	    border-radius: 0;
	    -webkit-box-align: center;
	    -webkit-box-pack: center;
	    min-width: 204px;
	    justify-content : center;
	    font-size: 14px;
	    line-height: 21px;
	    box-shadow: none;
	    bottom: 30px;
	    padding: 10px 0;
        font-weight: 700;
	    text-align: center;
        transition: background 2s;
	    z-index: 10;
        animation: loadSlow 1s linear forwards;
		}
		.top-thin-banner.voucher{
		background: #00a3ff;
    	color: #fff;
		}
		.top-thin-banner.voucher img {
	    height: 30px;
	    margin-right: 26px;
		}
		.top-thin-banner.voucher>p {
	    margin-right: 6px;
		}
		.top-thin-banner>p {
	    display: inline-block;
	    position: relative;
		}
		.top-thin-banner.voucher span {
	    color: #ffe814;
		}
		.top-thin-banner.voucher .arrow-w {
	    display: inline-block;
	    width: 20px;
	    height: 20px;
	    background: url(https://flow.team/flow-renewal/homepage/flow/ko/assets/images/circle-arrow-w.svg) center right/20px;
		}
		.with-header .renewal-section.innerSection {
	    background-color: transparent;
		}
		.with-header.innerSection {
		margin-top: 50px;
	    padding: 0 50px;
	    max-width: 100%;
	    height: 80px;
	    display: flex;
	    -webkit-box-align: center;
        align-items: center;
		}
		.innerSection{
		position: relative;
		margin: 0 auto;
		margin-top: 50px;
	    padding: 0 50px;
	    display: flex;
	    -webkit-box-pack: justify;
	    justify-content: space-between;
	    -webkit-box-align: center;
	    align-items: center;
	    max-width: 1920px;
	    height: 100%;
			}
		h1, h2, h3, h4, h5, h6 {
	    font-size: inherit;
	    line-height: normal;
		}
		.with-header .logo {
	    display: -webkit-box;
	    display: -webkit-flex;
	    display: -moz-box;
	    display: flex;
	    margin: 0;
	    font-size: 0;
		}
		.with-header .logo img {
	    width: 100%;
		}
		.with-header .logo>a {
	    display: block;
	    min-width: 128px;
		}
		img {
	    max-width: 100%;
	    vertical-align: top;
		}
		.with-header nav.gnb {
	    display: flex;
	    width: 100%;
	    height: inherit;
		}
		.with-header nav.gnb>ul {
	    display: flex;
	    -webkit-box-align: center;
	    align-items: center;
		}
		.with-header nav.gnb>ul li.gnbList {
		    position: relative;
		    margin-left: 35px;
		    cursor: pointer;
		}
		.with-header nav.gnb>ul li.gnbList a {
	    display: block;
	    font-size: 16px;
	    font-weight: 700;
	    border: 1px solid transparent;
		}
		li, ul {
	    list-style: none;
		}
		.with-header nav.gnb>ul li.gnbList .icons-arrow-textgo {
	    margin: -3px 0 0 6px;
	    display: inline-block;
	    vertical-align: middle;
	    color: #333;
	    font-size: 10px;
	    transform: rotate(90deg);
		}
		.with-header ul.gnbDepth {
		color:#333;
		font-weight:600;
	    display: none;
	    position: absolute;
	    top: 36px;
	    left: -26px;
	    width: auto;
	    padding: 10px 20px 20px 15px;
	    border: 1px solid #ccc;
	    -webkit-box-shadow: 0 2px 6px rgba(0,0,0,.15);
	    box-shadow: 0 2px 6px rgba(0,0,0,.15);
	    -webkit-border-radius: 10px;
	    border-radius: 10px;
	    background: #fff;
	    text-align: left;
	    white-space: nowrap;
	    }
	    
	    .with-header ul.gnbDepth>li>a {
	    padding: 6px 10px;
	    line-height: 21px;
	    }
		.with-header .loginList {
		position: relative;
    	margin-left: auto;
		}
		.with-header .loginList li {
	    margin-left: 8px;
	    display: inline-block;
	    vertical-align: middle;
	    color: #333;
	    font-weight: 700;
		}
		.with-header .loginList li a {
	    font-size: 14px;
	    margin-left:10px;
		}
		.btn-common{
		font-weight: 700;
	    line-height: 50px;
	    text-align: left;
		}
		.with-header .loginList .btn-login {
	    padding: 6px 18px;
	    color: #fff;
	    background: #00BFFF;
	    border: 1px solid #00BFFF;
	    border-radius: 25px;
		}
		.with-header .loginList .btn-login:hover {
	    text-decoration: underline;
	    cursor: pointer;
		background: #00A3FF;
		}
		.gnb li:hover {
		text-decoration: underline;
		cursor: pointer;
		color: #00BFFF;
		}
		.gnb li:hover .gnbDepth{
		margin-top:-15px;
		border:1px solid #9C9C9C;
		display:block;
		}
		.gnb li ul li:hover a{
		border-bottom:3px solid black;
		}
				
		.with-header .loginList .login-tooltip {
		z-index:1;
	    display: block;
	    position: absolute;
	    top: 48px;
	    right: 0;
	    padding: 5px 7px 5px 7px;
	    background: #fff;
	    border: 1px solid #555;
	    border-radius: 3px;
	    color: #623ad6;
	    font-size: 12px;
	    font-weight: 500;
	    line-height: 18px;
	    filter: drop-shadow(10px 10px 30px rgba(0, 0, 0, .1));
	    margin-right: 0px;
		}
		.with-header .loginList .login-tooltip:before {
	    position: absolute;
	    top: -6px;
	    left: 62%;
	    display: block;
	    content: "";
	    width: 11px;
	    height: 6px;
	    background: url(https://flow.team/flow-renewal/assets/images/sprite-project-detail.png) no-repeat -720px -175px;
	    background-size: 844px auto;
	    -ms-transform: translateX(-49.9%);
		}
		.with-header nav.gnb ul li.gnbList .consult-click {
	    display: inline-block;
	    width: 24px;
	    height: 24px;
	    margin-right: 2px;
	    background: url(Images/docu.png) center no-repeat;
	    background-size: contain;
		}
		
		h2 {
	    display: block;
	    font-size: 1.5em;
	    margin-block-start: 0.83em;
	    margin-block-end: 0.83em;
	    margin-inline-start: 0px;
	    margin-inline-end: 0px;
	    font-weight: bold;
		}
		p {
	    display: block;
	    margin-block-start: 1em;
	    margin-block-end: 1em;
	    margin-inline-start: 0px;
	    margin-inline-end: 0px;
		}
		
		.btn-contents:hover {
	    background: #008BDA;
		text-decoration: underline;
		}
		.btn-common {
		border-radius: 900px;
	    color: #fff;
		}
		.btn{
		display: inline;
	    width: 225px;
	    height: 63px;
	    padding: 16px 37px;
	    font-size: 20px;
	    font-weight: 500;
	    line-height: normal;
		}
		
		.with-header nav.gnb>ul li.gnbList:last-of-type .consult-click+span {
	    position: relative;
	    top: -5px;
	    color: #00A3FF;
	    font-weight:700;
		}
		
		.gnbDepth li:hover .deepdeepth {
		display:block;
		text-decoration:underline;
 		text-decoration-color:white;
		color:#333;
		}
		.deepdeepth{
		display:none;
 		margin-bottom:15px;
		}
		.deepdeepth li{
		margin-bottom:15px;
		margin-left:-40px;
		text-decoration : none;
		}
		.productMenu{
		font-size: 16px;
	    font-weight: 700;
	    border: 1px solid transparent;
	    
		}
		.team-step{
		text-align:center;
		max-width:586px;
		margin:0 auto;
		margin-top:200px;
		margin-bottom:300px;
		}
		.with-account {
	    padding: 6px 0 16px;
	    font-size: 36px;
	    color: #333;
	    font-weight: 700;
	    text-align: center;
	    margin-bottom: 15px;
		}
		.join-text-bold {
	    margin: 0 auto;
	    padding: 0 20px;
	    font-weight: 500;
	    font-size: 18px;
	    color: #333;
	    text-align: center;
	    line-height: 27px;
		}
		.join-input-wrap {
	    width: 586px;
	    margin: 80px auto 0 auto;
	    text-align: center;
		}
		.join-input-wrap label {
	    display: block;
	    text-align: left;
		}
		.join-input-wrap input {
	    color: #333;
	    font-size: 16px;
		}
		.join-label-title {
	    display: inline-block;
	    margin-bottom: 10px;
	    padding: 3px 0;
	    font-size: 16px;
	    color: #333;
	    font-weight: 700;
	    text-align: left;
		}
		.join-name-input {
	    width: 100%;
	    height: 52px;
	    border: 1px solid #ddd;
	    border-radius: 8px;
	    box-sizing: border-box;
	    padding-left: 20px;
		}
		.join-input-wrap .company-url {
	    display: flex;
	    -webkit-box-align: center;
	    align-items: center;
		}
		.join-input-wrap label+label {
    margin-top: 20px;
}
.join-input-wrap label {
    display: block;
    text-align: left;
}
.join-url-input {
    width: 100%;
    height: 52px;
    border: 1px solid #ddd;
    box-sizing: border-box;
    padding-left: 20px;
    border-radius: 8px;
    margin: 0 10px;
}
.join-select {
    position: relative;
}
.join-select select {
    width: 100%;
    height: 52px;
    padding-left: 20px;
    font-size: 16px;
    background: #fff;
    border: 1px solid #ddd;
    color: #333;
    box-sizing: border-box;
    border-radius: 8px;
}
.join-button-wrap {
    margin-top: 60px;
    display: flex;
}
.join-button-prev {
    -webkit-box-flex: 1;
    flex: 1;
    display: inline-block;
    height: 52px;
    line-height: 50px;
    border: 1px solid #00BFFF;
    box-sizing: border-box;
    border-radius: 6px;
    color: #00BFFF;
    text-align: center;
    font-weight: 700;
    }
    .join-button-prev:hover{
    background:#00BFFF;
    color:#fff;
    }
    .join-button-next {
    -webkit-box-flex: 1;
    flex: 1;
    display: inline-block;
    height: 52px;
    line-height: 50px;
    color: #fff;
    background: #00BFFF;
    border-radius: 6px;
    text-align: center;
    margin-left: 10px;
	}
	.join-button-next:hover{
	background:#0085D0;
	border-color:#00BFFF;
	}
	.flow-footer .innerSection {
    padding: 50px;
    display: -webkit-box;
    display: -webkit-flex;
    display: -moz-box;
    display: flex;
    -webkit-box-pack: justify;
    -webkit-justify-content: space-between;
    -moz-box-pack: justify;
    justify-content: space-between;
    max-width: 100%;
}
.flow-footer ul.brochure li a {
    padding: 10px 20px;
    display: block;
    color: #555;
    font-size: 13px;
    font-weight: 700;
    line-height: 20px;
    -webkit-border-radius: 35px;
    border-radius: 35px;
    background: #eee;
    cursor: pointer;
}
.flow-footer ul.siteMap {
    display: -webkit-box;
    display: -webkit-flex;
    display: -moz-box;
    display: flex;
    -webkit-box-pack: justify;
    -webkit-justify-content: space-between;
    -moz-box-pack: justify;
    justify-content: space-between;
    padding-inline-start: 0px;
    margin: 0px;
}
.flow-footer ul.brochure {
    display: flex;
    padding-inline-start: 0px;
}
.flow-footer ul.brochure li {
    margin-right: 10px;
}
.flow-footer ul.address {
    margin: 30px auto;
    padding-inline-start: 0px;
}
b {
    font-weight: bold;
}
.flow-footer ul.address li p {
    margin-right: 6px;
    display: inline-block;
}
.flow-footer ul.address li {
    margin-top: 0px;
    color: #777;
    font-size: 13px;
    line-height: 0px;
}
.flow-footer ul.social {
    display: -webkit-box;
    display: -webkit-flex;
    display: -moz-box;
    display: flex;
    -webkit-box-pack: start;
    -webkit-justify-content: flex-start;
    -moz-box-pack: start;
    justify-content: flex-start;
    -webkit-align-content: center;
    align-content: center;
}
.flow-footer ul.social a {
    display: block;
    width: 30px;
    height: 30px;
    background-position: center center;
    background-repeat: no-repeat;
}
.flow-footer ul.social a.yt {
    background-image: url(https://flow.team/flow-renewal/homepage/flow/ko/assets/images/common/sns-yt.svg);
    margin-right: 10px;
}
.flow-footer ul.social a.fb {
    background-image: url(https://flow.team/flow-renewal/homepage/flow/ko/assets/images/common/sns-fb.svg);
    margin-right: 10px;
}
.flow-footer ul.social a.ins {
    background-image: url(https://flow.team/flow-renewal/homepage/flow/ko/assets/images/common/sns-ins.svg);
    margin-right: 10px;
}
.flow-footer ul.social a.flw {
    background-image: url(https://flow.team/flow-renewal/homepage/flow/ko/assets/images/common/sns-flw.svg);
}
.flow-footer ul.terms {
    margin-top: 30px;
    display: -webkit-box;
    display: -webkit-flex;
    display: -moz-box;
    display: flex;
}
.flow-footer ul.terms li {
    margin-right: 10px;
    color: #777;
    font-size: 13px;
    line-height: 20px;
}
.flow-footer ul.siteMap>li {
    margin-left: 10px;
    min-width: 130px;
}
.flow-footer ul.siteMap>li ol>li {
    margin-top: 14px;
    color: #555;
    font-size: 14px;
    line-height: 21px;
}
.businessBanner {
    position: relative;
    padding: 76px 0;
    height: 400px!important;
    background:linear-gradient(rgba(0, 0, 0, 0.527), rgba(0, 0, 0, 0.5)), url(https://flow.team/flow-renewal/homepage/flow/ko/assets/images/common/businessBanner.jpg) center no-repeat;
    background-size: cover;
}
.businessBanner p {
    margin: 30px 0!important;
    color: #fff;
    font-size: 24px!important;
    line-height: 40px!important;
}
.businessBanner .textWrap {
    width: 100%!important;
}
.businessBanner .btn-contents {
    margin-top: 0!important;
    padding: 0 50px 0 28px;
    display: inline-block;
    width: auto;
    color: #fff;
    background: 0 0;
    border: 1px solid #fff!important;
} 
	</style>
</head>
<body>
	<header class="with-header main">
			<a class="top-thin-banner voucher border" 
			href="https://sites.google.com/flow.team/2023goodchance?utm_source=service&utm_medium=homepage&utm_campaign=voucher2023"
			target="_blank">
				<img src="https://flow.team/flow-renewal/homepage/flow/ko/assets/images/logo_gov.svg" alt="정부 로고">
				<p>
					정부 지원금
					<span>최대 200만원</span> 받기
				</p>
				<i class="arrow-w"></i>
			</a>
			<div class="innerSection renewal-section">
				<h1 class="logo">
					<a title="With" href="메인.html">
						<img src="Images/with_logo.png" alt="with">
					</a>
				</h1>
				<nav class="gnb menu">
					<ul id="Gnb">
						<li class="gnbList">
							<a title="회사소개">
								회사소개
								<i class="fa-solid fa-chevron-down"></i>
							</a>
							<ul class="gnbDepth productMenu">
								<li>
									<a title="회사소개" href="회사소개.html"></a>
									회사소개
								</li>
								<li>
									<a title="제품" href=""></a>
									제품
									<i class="fa-solid fa-chevron-down"></i>
									
									<ul class="deepdeepth">
										<li><br/>
											<i class="fa-solid fa-people-group" style="color:green;"></i>
											<a href="프로젝트협업.html" style="display:inline;">프로젝트 협업</a>
										</li>
										<li>
											<i class="fa-regular fa-paste" style="color:purple"></i>
											<a title="업무관리" href="업무관리.html" style="display:inline;">업무관리</a>
										</li>
										<li>
											<i class="fa-regular fa-comment-dots" style="color:orange;"></i>
											<a title="메신저" href="메신저.html" style="display:inline;">메신저</a>
										</li>
										<li>
											<i class="fa-solid fa-flag-checkered" style="color:yellow;"></i>
											<a title="OKR" href="OKR.html" style="display:inline;">OKR</a>
										</li>
										<li>
											<i class="fa-solid fa-video" style="color:skyblue;"></i>
											<a title="화상회의" href="화상회의.html" style="display:inline;">화상회의</a>
										</li>
										<li>
											<i class="fa-solid fa-shield-halved" style="color:orange;"></i>
											<a title="보안기능" href="보안기능.html" style="display:inline;">보안기능</a>
										</li>
									</ul>
								</li>
							</ul>
						</li>
						<li class="gnbList">
							<a title="요금" href="요금제.html">
								요금
							</a>
							
						</li>
						<li class="gnbList">
							<a title="고객사례" href="고객.html">
							고객사례
							</a>
						</li>
						<li class="gnbList">
							<a title="자료실" href="자료실.html">
							자료실
							</a>
						</li>
						<li class="gnbList">
						<a title="소개서 받기" href="javascript:void(0);" class="product-intro-link" onclick="openPopup()">
							<i class="consult-click"></i>
							<span>소개서 받기</span>
							</a>
						</li>
					</ul>
					<ul class="loginList">
						<li>
							<a title="로그인" href="로그인.jsp">
							로그인
							</a>
						</li>
						<li>
							<a title="회원가입" href="회원가입.html" class="js-signup-btn btn-login btn-common">
							무료 회원가입
							</a>
						</li>
						<span class="login-tooltip">
							join with WITH!
						</span>
					</ul>
				</nav>
			</div>
		</header>
		<div class="team-step">
			<div class="with-account">
				새 회사 만들기
			</div>
			<div class="join-text-bold">
				회사정보 입력 후,플로우 관리자로 시작해 보세요.
			</div>
			<div class="join-input-wrap">
				<label>
					<div class="join-label-title">회사 이름</div>
					<input type="text" class="join-name-input" placeholder="회사 이름">
				</label>
				<label>
					<div class="join-label-title">
						회사 URL
					</div>
					<div class="company-url">
						<span>https://</span>
						<input type="text" class="join-url-input" placeholder="회사 URL">
						<span>with.team</span>
					</div>
				</label>
				<label>
					<div class="join-label-title">회사 업종</div>
					<div class="join-select">
						<select>
							<option value="default" selected disabled hidden>회사 업종을 선택하세요</option>
							<option value="default">제조업</option>
							<option value="default">정보통신업(IT)</option>
							<option value="default">F&B, 프랜차이즈</option>
							<option value="default">도·소매 유통 판매</option>
							<option value="default">엔터테인먼트, 여행, 예술</option>
							<option value="default">공공 행정</option>
							<option value="default">건설 및 기간 산업</option>
							<option value="default">새무, 법무, 노무</option>
							<option value="default">운수 및 물류</option>
							<option value="default">의료 보건, 사회 복지</option>
							<option value="default">금융, 보험, 부동산</option>
							<option value="default">협회 및 단체</option>
							<option value="default">교육 및 연구</option>
							<option value="default">1차산업(농·임·수산업)</option>
							<option value="default">기타</option>
						</select>
					</div>
				</label>
				<div class="join-button-wrap">
					<a id="movePrevStepButton" class="join-button-prev" href="새회사만들기1.jsp">이전</a>
					<a id="moveNextStepButton" class="join-button-next" >다음</a>
				</div>
				<div>
				
				</div>
			</div>
			
		</div>
		<article class="businessBanner">
					<div class="innerSection contentsWrap"
						style="opacity: 1; transform: translateY(0px);">
						<div class="textWrap">
							<p class="textSubTitle">
								메신저・프로젝트 소통・워크플로우<br/>
								화상회의까지 ㅡ<br/>
								이 모든 기능을 플로우로 체험해보세요.
							</p>
							<a title="무료로 시작하기" href="/signup.act"
								class="btn-common btn-contents" target="_self">무료로 시작하기
								<i class="fa-solid fa-chevron-down"></i></a>
						</div>
					</div>
				</article>
	</section> <footer class="flow-footer">
				<div class="innerSection">
					<div class="companyInfo">
						<ul class="brochure">
							<li><a title="소개 및 비교자료" href="https://flow.team/kr/consult?contact=resource">소개
									및 비교자료<i class="icons-arrow-textgo"></i>
							</a></li>
							<li><a title="도입문의" href="https://flow.team/kr/project">도입문의<i
									class="icons-arrow-textgo"></i></a></li>
							<li class="js-go-url" data-code="blog"><a title="플로우 블로그" href="https://post.flow.team/">플로우
									블로그<i class="icons-arrow-textgo"></i>
							</a></li>
						</ul>
						<ul class="address">
							<li>
								<p>
									<b>주소</b> 서울특별시 영등포구 영신로 220 KnK디지털타워 1410호
								</p>
							</li>
							<li>
								<p>
									<b>마드라스체크㈜대표자</b> 이학준
								</p>
								<p>
									<b>전화</b> 1522-9298
								</p>
								<p>
									<b>이메일</b> support@flow.team
								</p>
							</li>
							<li>
								<p>
									<b>통신판매업신고번호</b> 제2019-서울영등포-0298호
								</p>
								<p>
									<b>사업자등록번호</b> 189-87-00172
								</p>
							</li>
						</ul>
						<ul class="social">
							<li><a
								href="https://www.youtube.com/channel/UCmnzKvpQMl8uyT1PUMdPsXQ"
								title="유튜브" class="yt" target="_blank"></a></li>
							<li><a href="https://www.facebook.com/flow.team/"
								title="페이스북" class="fb" target="_blank"></a></li>
							<li><a href="https://www.instagram.com/flow.tool/"
								title="인스타그램" class="ins" target="_blank"></a></li>
							<li><a href="https://www.instagram.com/flow.designlab/"
								title="디자인랩" class="flw" target="_blank"></a></li>



						</ul>

						<ul class="terms">
							<li><a title="이용약관" href="https://flow.team/kr/terms">이용약관</a></li>
							<li><a title="개인정보 처리방침" href="https://flow.team/kr/privacy"><b>개인정보
										처리방침</b></a></li>
							<li class="copyright">ⓒ 2021 Madras check All rights
								Reserved.</li>
						</ul>
					</div>
					<div class="companySide">
						<ul class="siteMap menu">
							<li>
								<ol>
									<li><b>회사소개</b></li>
									<li><a title="스토리" href="https://flow.team/kr/company">스토리</a></li>
									<li><a title="문화복지" href="https://flow.team/kr/culture">문화복지</a></li>
									<li><a title="멤버소개" href="https://flow.team/kr/members">멤버소개</a></li>
									<li><a title="채용" href="https://flow.team/kr/recruit">채용</a></li>
								</ol>
							</li>
							<li>
								<ol>
									<li><b>제품</b></li>
									<li><a title="프로젝트 협업" href="https://flow.team/kr/project">프로젝트 협업</a></li>
									<li><a title="업무관리" href="https://flow.team/kr/task">업무관리</a></li>
									<li><a title="메신저" href="https://flow.team/kr/chatting">메신저</a></li>
									<li><a title="OKR" href="https://flow.team/kr/okr-introduction" class="">OKR</a></li>
									<li><a title="화상회의" href="https://flow.team/kr/video">화상회의</a></li>
									<li><a title="보안기능" href="https://flow.team/kr/security">보안기능</a></li>
									<li><a title="시스템 연동" href="https://flow.team/kr/system">시스템 연동</a></li>
									<li><a title="다운로드" href="https://flow.team/kr/download">다운로드</a></li>
								</ol>
							</li>
							<li>
								<ol>
									<li><b>요금</b></li>
									<li><a title="요금제" href="https://flow.team/kr/price">요금제</a></li>
									<li><a title="구축형 문의" href="https://flow.team/kr/build">구축형 문의</a></li>
									<li><a title="유료 VS 무료" href="https://flow.team/kr/guest-vs-business">유료
											VS 무료</a></li>
								</ol>
							</li>
							<li>
								<ol>
									<li><b>교육</b></li>
									<li><a title="온라인 강의실"
										href="https://edu.flow.team/classes" target="_blank">온라인
											강의실</a></li>
									<li><a title="동영상 매뉴얼" href="https://flow.team/kr/manual">동영상 매뉴얼</a></li>
									<li class="js-go-url" data-code="faq"><a title="자주묻는 질문">자주묻는
											질문</a></li>
								</ol>
							</li>
							<li>
								<ol>
									<li><b>자료실</b></li>
									<li><a title="재택근무 활용" href="https://flow.team/kr/untact_use">재택근무 활용</a></li>
									<li class="js-go-url" data-code="tip"><a title="활용방법">활용방법</a></li>
									<li class="js-go-url" data-code="insight"><a title="인사이트">인사이트</a></li>
									<li class="js-go-url" data-code="video"><a title="웨비나">웨비나</a></li>
									<li class="js-go-url" data-code="interview"><a
										title="성공사례">성공사례</a></li>
									<li class="js-go-url" data-code="news"><a title="보도자료">보도자료</a></li>
								</ol>
							</li>
							<li>
								<ol>
									<li><b>파트너</b></li>
									<li><a title="파트너 소개" href="https://flow.team/kr/partner/info">파트너 소개</a></li>
									<li><a title="파트너 모집" href="https://flow.team/kr/partner/pt-recruit">파트너
											모집</a></li>
								</ol>
							</li>
						</ul>
					</div>
				</div>

			</footer>
</body>
</html>

<script>
	$(function(){
		$("#moveNextStepButton").click(function(){
			if($(".join-name-input").val()==""){
				alert("회사명을 입력하세요.");
			}else if ($(".join-url-input").val() === "") {
				alert("회사URL을 입력하세요.");
			}else if (!/^[a-z0-9]{4,}$/i.test($(".join-url-input").val())) {
				alert("영어 소문자나 숫자 로만 이루어져 있으며, 최소 4글자 이상인 url을 입력하세요")
			}else{
				let company_url = $(".join-url-input").val();
				check_company_url(company_url);
			}
		});
		
		function check_company_url(company_url){
			$.ajax({
				url:"login",
				type:"POST",
				data:{
					send_num:6,
					send_url:company_url
				},
				success: function(abc){
					if(abc==1){
						alert("이미 존재하는 URL 입니다.");
					}else{
						let id = '<%=id%>';
						let pw = '<%=pw%>';
						let name = '<%=name%>';
						let job = '<%=job%>';
						let company_name = $(".join-name-input").val();
						create_account_company(id,pw,name,job,company_name,company_url);
						location.href="새회사만들기마지막.jsp";
					}
				}
			});
		}
		function create_account_company(id,pw,name,job,company_name,company_url){
			alert(company_url);
			$.ajax({
				url:"login",
				type:"POST",
				data:{
					send_num:7,
					send_id:id,
					send_pw:pw,
					send_name:name,
					send_job:job,
					send_company_name:company_name,
					send_url:company_url
				},
				success: function(abc){
				}
			});
		}
	});
</script>

































