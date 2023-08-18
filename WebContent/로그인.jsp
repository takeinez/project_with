<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page session="true" %>
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
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	<script>
		
		window.Kakao.init("def19007b545cfc1a84b3e6a9d33176f");
		function kakaoLogin(){
			window.Kakao.Auth.login({
				scope:'profile_nickname,account_email',
				success: function(authObj){
					console.log(authObj);
					window.Kakao.API.request({
						url:'/v2/user/me',
						success: res => {
							const kakao_account = res.kakao_account;
							console.log(kakao_account);
							let email = kakao_account.email;
							let nickName = kakao_account.profile.nickname;
							kakao_loginAction(email,nickName);
						}
					});
				}
			});
		}
		function kakao_loginAction(inputId,inputName){
			$.ajax({
				url: "login",
				type: "POST",
				data: {
					send_num:1,
					send_id: inputId,
					send_pw: ""
				},
				
				success: function(check){
					if(check==0){
						create_kakao_account(inputId,inputName);
					}else if(check==2||check==1){
						 var form = $('<form>', {
						        'method': 'POST',
						        'action': 'login'
						    });

						    $('<input>').attr({
						        'type': 'hidden',
						        'name': 'send_num',
						        'value': 0
						    }).appendTo(form);

						    $('<input>').attr({
						        'type': 'hidden',
						        'name': 'id',
						        'value': inputId
						    }).appendTo(form);

						    form.appendTo($('body')).submit();
					}else if(check==4){
						alert("가입 승인이 필요합니다.");
						$("#loginForm input").val("");
					}else{
						alert("뭔가 잘못되었습니다.");
						$("#loginForm input").val("");
					}
				}
			});
		}
		function create_kakao_account(inputId,inputName){
			alert("왔어2");
			$.ajax({
				url: "login",
				type: "POST",
				data: {
					send_num:10,
					send_id: inputId,
					send_name: inputName
				},
				
				success: function(){
					alert("계정 생성 완료!");
				}
			});
		}
	</script>
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
		.error-text {
	    text-align: left;
	    margin-top: 10px;
	    color: #ff6b6b;
	    font-size: 14px;
	    line-height: 21px;
		}
		.login-id-input .input-error  {
	    color: #ff6b6b;
	    border: 1px solid #ff6b6b !important;
		}
		input:focus {outline: none;}
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
		.auto-login-label.auto-login-active a {
    	background-position: -380px -153px;
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
		.flow-footer .innerSection {
		background:#F5F4F4;
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
		.login-wrap {
	    max-width: 586px;
	    margin: 0 auto;
	    margin-top:200px;
	    margin-bottom:200px;
	    text-align: center;
		}
		.login-text {
	    display: block;
	    font-size: 36px;
	    color: #333;
	    font-weight: 700;
	    margin: 0 auto 30px;
	    text-align: center;
		}
		.login-id-input {
	    position: relative;
	    margin-bottom: 12px;
		}
		.login-id-input input {
	    width: 100%;
	    height: 52px;
	    background: #fff;
	    border: 1px solid #ddd;
	    box-sizing: border-box;
	    border-radius: 8px;
	    padding-left: 20px;
	    font-size: 16px;
		}
		.login-password-input {
	    position: relative;
		}
		.login-password-input input {
	    width: 100%;
	    height: 52px;
	    background: #fff;
	    border: 1px solid #ddd;
	    box-sizing: border-box;
	    border-radius: 8px;
	    padding-left: 20px;
	    font-size: 16px;
		}
		.login-find-section {
	    margin: 20px 0 0 0;
	    text-align: left;
		}
		.login-find-section span {
	    color: #333;
	    font-size: 14px;
		}
		.login-password-find {
	    font-weight: 500;
	    text-decoration: underline;
		}
		.login-button {
	    display: block;
	    color: #fff;
	    text-align: center;
	    background: #00BFFF;
	    line-height: 52px;
	    height: 52px;
	    width: 100%;
	    border-radius: 8px;
	    margin-top: 20px;
	    font-weight: 500;
	    font-size: 16px;
		}
		.login-button:hover{
		background:#0085D0;
		}
		.cursor-pointer {
	    cursor: pointer;
		}
		.auto-login-label {
	    display: block;
	    margin-top: 20px;
	    cursor: pointer;
	    font-size: 14px;
	    color: #333;
	    font-weight: 500;
	    text-align: left;
		}
		.auto-login-label:hover {
		    color: #00BFFF;
		}
		.auto-login-label a {
	    display: inline-block;
	    position: relative;
	    background: url(https://flow.team/flow-renewal/assets/images/login-sprite.png) no-repeat -336px -153px;
	    background-size: 660px auto;
	    width: 21px;
	    height: 20px;
	    margin: -1px 6px 0 0;
	    vertical-align: top;
		}
		.auto-login-label.auto-login-active a:hover {
	    background-position: -380px -153px;
		}
		.guest-or {
	    position: relative;
	    margin: 40px 0;
	    font-size: 14px;
	    color: #333;
		}
		.guest-or::before {
	    display: inline-block;
	    content: "";
	    width: 100%;
	    max-width: 244px;
	    height: 1px;
	    margin-right: 30px;
	    background: #ddd;
	    vertical-align: middle;
		}
		.guest-or::after {
	    display: inline-block;
	    content: "";
	    width: 100%;
	    max-width: 244px;
	    height: 1px;
	    margin-left: 30px;
	    background: #ddd;
	    vertical-align: middle;
		}
		.login-google, .login-kakao, .login-apple{
	    display: block;
	    width: 100%;
	    height: 52px;
	    background: #fff;
	    border: 1px solid #777;
	    box-sizing: border-box;
	    border-radius: 8px;
	    line-height: 52px;
	    text-align: center;
	    font-size: 16px;
	    font-weight: 500;
	    color: #333;
		}
		.login-kakao, .login-apple{
	    margin-top: 12px;
		}
		.login-google:hover {
	    border-color: #0085D0;
	    color: #0085D0;
		}
		.login-kakao:hover {
	    border-color: #0085D0;
	    color: #0085D0;
		}
		.login-apple:hover {
	    border-color: #0085D0;
	    color: #0085D0;
		}
		.login-google em {
	    display: inline-block;
	    background: url(https://flow.team/flow-renewal/assets/images/login-sprite.png) no-repeat -402px -153px;
	    background-size: 660px auto;
	    width: 23px;
	    height: 22px;
	    position: relative;
	    top: 5px;
	    margin-right: 9px;
		}
		.login-kakao em {
	    display: inline-block;
	    background: url(https://flow.team/flow-renewal/assets/images/login-sprite.png) no-repeat -426px -153px;
	    background-size: 660px auto;
	    width: 23px;
	    height: 22px;
	    position: relative;
	    top: 5px;
	    margin-right: 9px;
		}
		.login-apple em {
	    display: inline-block;
	    background: url(https://flow.team/flow-renewal/assets/images/login-sprite.png) no-repeat -451px -153px;
	    background-size: 660px auto;
	    width: 22px;
	    height: 22px;
	    position: relative;
	    top: 5px;
	    margin-right: 10px;
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
									<a title="회사소개" href=""></a>
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
<!-- 							<a title="소개서 받기" href="" class="product-intro-link"> -->
							<i class="consult-click"></i>
							<span>소개서 받기</span>
							</a>
						</li>
					</ul>
					<ul class="loginList">
						<li>
							<a title="로그인" href="">
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
		<div class="login-wrap">
			<div class="login-text">
				로그인
			</div>
			<form id="loginForm" action="login" method="post">
				<div class="login-id-input">
					<input id="userId" name="id" type="text" placeholder="아이디">
					<input id="hide" type="hidden" name="send_num" value="0" >
					<p class="error-text" data-error-code="2000"></p>
				</div>
				<div class="login-password-input">
					<input id="password"  type="password" placeholder="비밀번호">
					<p class="error-text" data-error-code="2000"></p>
				</div>
				<div class="login-find-section">
					<a href="비밀번호찾기.jsp">
						<span class="login-password-find">비밀번호 찾기</span>
					</a>
				</div>
				<a id="normalLoginButton" class="login-button cursor-pointer">로그인</a>
<!-- 				<div class="auto-login-label"> -->
<!-- 					<a class="cursor-pointer"></a> -->
					
<!-- 					자동 로그인 -->
<!-- 				</div> -->
			</form>
			<div class="guest-or" style="display:block;">
				또는
			</div>
<!-- 			<a class="login-google cursor-pointer" style="display:block;"> -->
<!-- 				<em></em> -->
<!-- 				<span>Google 계정으로 로그인</span> -->
<!-- 			</a> -->
			<a class="login-kakao cursor-pointer" href="javascript:kakaoLogin();" style="display:block;">
				<em></em>
				<span>Kakao 계정으로 로그인</span>
			</a>
<!-- 			<a class="login-apple cursor-pointer" style="display:block;"> -->
<!-- 				<em></em> -->
<!-- 				<span>Apple 계정으로 로그인</span> -->
<!-- 			</a> -->
		</div>
		<footer class="flow-footer">
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
		$(document).on("click","#normalLoginButton",function(){ //로그인 유효성검사
			let inputId = $("#userId").val();
			let inputPw = $("#password").val();
			let checkID = RegExp(/^[\w.-]{6,30}@[a-zA-Z\d.-]+\.[a-zA-Z]{2,}$/);
			if(inputId==""){
				$(".login-id-input p").html("아이디를 입력해주세요.");
				$(".login-id-input input").addClass("input-error");
			}else if(inputPw==""){
				$(".login-password-input p").html("패스워드를 입력해주세요.");
				$(".login-password-input input").addClass("input-error");
			}else if(!checkID.test($("#userId").val())){
				$(".login-id-input p").html("아이디는 6~30자의 영문 소문자, 숫자를 포함한 이메일 형식만 사용 가능합니다.");
				$(".login-id-input input").addClass("input-error");
			}else if(!/^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,25}$/.test($("#password").val())){
				$(".login-password-input p").html("비밀번호는 영문자, 숫자, 특수문자의 조합으로8~15자리로 입력해주세요.");
				$(".login-password-input input").addClass("input-error");
			}else if($("#password").val().length < 8 || $("#password").val().length >15){
				$(".login-password-input p").html("비밀번호는 영문자, 숫자, 특수문자의 조합으로8~15자리로 입력해주세요.");
				$(".login-password-input input").addClass("input-error");
			}else{
				loginAction(inputId,inputPw);
			}
			
			$("#loginForm input").val("");
		});
		
		$(document).on("change","#userId,#password",function(){
			$(".login-id-input input,.login-password-input input").removeClass("input-error");
			$(".login-password-input p,.login-id-input p").html("");
		});
		
		$(".auto-login-label").click(function(){
			if($(".auto-login-label").hasClass("auto-login-active")){
				$(".auto-login-label").removeClass("auto-login-active");
			}else{
				$(".auto-login-label").addClass("auto-login-active");
			}
		});
		
		
	});
	function loginAction(inputId,inputPw){
		$.ajax({
			url: "login",
			type: "POST",
			data: {
				send_num:1,
				send_id: inputId,
				send_pw: inputPw
			},
			
			success: function(check){
				if(check==0){
					$(".login-id-input p").html("존재하지 않는 아이디입니다.");
					$(".login-id-input input").addClass("input-error");
				}else if(check==2){
					$(".login-password-input p").html("비밀번호가 일치하지 않습니다.");
					$(".login-password-input input").addClass("input-error");
				}else if(check==1){
					$("#hide").val(0);
					$("#userId").val(inputId);
					$("#loginForm").submit();
				}else if(check==4){
					alert("가입 승인이 필요합니다.");
					$("#loginForm input").val("");
				}else{
					alert("뭔가 잘못되었습니다.");
					$("#loginForm input").val("");
				}
			}
		});
	}
	
	
</script>