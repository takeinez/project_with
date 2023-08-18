<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String loginId = (String) session.getAttribute("loginId");
	
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String dbId = "alone";
	String dbPw = "1234";
	Class.forName(driver);
	Connection conn = DriverManager.getConnection(url, dbId, dbPw);
	
	String sql = "SELECT COUNT(*) AS employee_count FROM employees WHERE company_id = (SELECT company_id FROM employees WHERE employee_id = ?)";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, loginId);
	ResultSet rs = pstmt.executeQuery();
	
	int employee_count = 0;
	if(rs.next()) {
		employee_count = rs.getInt("employee_count");
	}
	
	rs.close();
	pstmt.close();
	conn.close();
%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&family=Noto+Sans+KR:wght@400;700&family=Noto+Sans+JP:wght@400;700&family=Be+Vietnam+Pro:wght@400;700&family=Arial&family=Helvetica&family=sans-serif&family=Twemoji+Country+Flags&display=swap" rel="stylesheet">
<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.3.0/kakao.min.js" integrity="sha384-70k0rrouSYPWJt7q9rSTKpiTfX6USlMYjZUtr1Du+9o4cGvhPAWxngdtVZDdErlh" crossorigin="anonymous"></script>

<link rel="stylesheet" href="css/all-common.css">
<link rel="stylesheet" href="css/tail.css">
<link rel="stylesheet" href="css/icon-contents.css">
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/alltask.css">
<link rel="stylesheet" href="css/upgrade-version.css">
<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/mainSearch.css">
<link rel="stylesheet" href="css/login.css">
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	var nowId = '<%=loginId%>';
	$(function() {
		$(".faqList a").click(function() {
			if($(this).parent().hasClass("active")) {
				$(this).parent().removeClass("active");
			} else {
				$(this).parent().addClass("active");
			}
		});
		
		$(".js-plan-btn").click(function() {
			$("#paymentLayer .flow-logo").hide();
			$("#paymentLayer .button-go-back").css("display", "flex");
			$("#paymentHeader").text("정기 결제 신청");
			$(".plan-banner.step2").show();
			
			if($(this).parent().find(".plan-name").text() == "비즈니스 베이직") {
				$(".js-plan-name").text("비즈니스 베이직");
				let userCnt = $("#userCnt").val();
				let price = userCnt * 72000;
				let formattedPrice = price.toLocaleString();
				$("#price").text(formattedPrice);
			} else if($(this).parent().find(".plan-name").text() == "비즈니스 프로") {
				$(".js-plan-name").text("비즈니스 프로");
				let userCnt = $("#userCnt").val();
				let price = userCnt * 96000;
				let formattedPrice = price.toLocaleString();
				$("#price").text(formattedPrice);
			}
			
			
			$(".pro-pay-wrap.step1").hide();
			$(".pro-pay-wrap.step2").show();
		});

		$("#paymentLayer .button-go-back").click(function() {
			$("#paymentLayer .flow-logo").show();
			$("#paymentLayer .button-go-back").css("display", "none");
			$("#paymentHeader").text("");
			
			$(".pro-pay-wrap.step1").show();
			$(".pro-pay-wrap.step2").hide();
		});
		
		$("#paymentAgree").click(function() {
			if($(this).hasClass("checked")) {
				$(this).removeClass("checked");
			} else {
				$(this).addClass("checked");
			}
		});
		
		$("#payOption").click(function() {
			if($("#payOptionSelect").css("display") == "none") {
				$("#payOptionSelect").show();	
			} else {
				$("#payOptionSelect").hide();	
			}
		});
		
		$("#monthSelect").click(function() {
			$("#payOption").text(" 월간 정기 결제 ");
			let userCnt = $("#userCnt").val();
			if($("#version").text() == "비즈니스 베이직") {
				let price = userCnt * 8000;	
				let formattedPrice = price.toLocaleString();
				$("#price").text(formattedPrice);
				$(".js-pay-gubun").text("월");
			} else if($("#version").text() == "비즈니스 프로") {
				let price = userCnt * 10000;
				let formattedPrice = price.toLocaleString();
				$("#price").text(formattedPrice);
				$(".js-pay-gubun").text("월");
			}
			$("#payOptionSelect").hide();
		});
		
		$("#yearSelect").click(function() {
			$("#payOption").html(' 연간 정기 결제  <span class="js-payment-sale payment-sale" style="display: inline-block;">약<em class="js-sale-percent">25%</em>할인</span>');
			let userCnt = $("#userCnt").val();
			let price;
			if($("#version").text() == "비즈니스 베이직") {
				price = userCnt * 72000;	
			} else if($("#version").text() == "비즈니스 프로") {
				price = userCnt * 96000;
			}
			let formattedPrice = price.toLocaleString();
			$("#price").text(formattedPrice);
			$(".js-pay-gubun").text("년");
			
			$("#payOptionSelect").hide();
		});
		
		$("#submitPayment").click(function() {

			if($("#kakao").css("display") != "none") {
				
				if($("#paymentAgree").hasClass("checked")) {
					$("p:contains('정기과금 이용약관에 동의해 주세요.')").hide();
					$.ajax({
		                method: "POST",
		                url: "https://kapi.kakao.com/v1/payment/ready",
		                data: {
		                   cid: "TC0ONETIME", 
		                   partner_order_id: "g_no가 들어갈자리",
		                   partner_user_id: "user nickname이 들어갈자리",
		                   item_name: "WITH",
		                   quantity: 1,
		                   total_amount: parseFloat($("#price").text().replace(/,/g, '')),
		                   tax_free_amount: 0,
		                   approval_url : "http://localhost:9080/Project_with/KakaoPayApproval.jsp",
		                   cancel_url: "http://localhost:9080/group5/paymentYGgames.jsp",
		                   fail_url: "http://localhost:9080/group5/paymentYGgames.jsp",
		                   },
		                headers: {Authorization: "KakaoAK 9bd667e73cd7b325c12249a3afe3e8f3"}
		             })
		             .done(function(msg){
		                window.open(msg.next_redirect_pc_url,'카카오페이QR결제','width: 100px, height: 200px; scrollbars=yes');
		             });	
				} else {
					$("p:contains('정기과금 이용약관에 동의해 주세요.')").show();
				}
				
			} else if($("#payInfoUl").css("display")=="block") {
				
				let userName = $("#userName").val();
//	 			alert(userName);
				if(userName=="") {
					$("#userName").addClass("input-error");
					$("#userName").parent().find("p").show();
				} else {
					$("#userName").removeClass("input-error");
					$("#userName").parent().find("p").hide();
				}
				let userEmail = $("#userEmail").val();
//	 			alert(userEmail);
				if(userEmail=="") {
					$("#userEmail").addClass("input-error");
				} else {
					$("#userEmail").removeClass("input-error");
				}
				let phoneNum = $("#phoneNum").val();
//	 			alert(phoneNum);
				if(phoneNum=="") {
					$("#phoneNum").addClass("input-error");
					$("#phoneNum").parent().find("p").show();
				} else {
					$("#phoneNum").removeClass("input-error");
					$("#phoneNum").parent().find("p").hide();
				}
				let longCardNum = $("#longCardNum").val();
//	 			alert(longCardNum);
				if(longCardNum.length<=14) {
					$("#longCardNum").addClass("input-error");
					$("#longCardNum").parent().find("p").show();
				} else {
					$("#longCardNum").removeClass("input-error");
					$("#longCardNum").parent().find("p").hide();
				}
				let expiryMonth = $("#expiryMonth option:selected").val();
//	 			alert(expiryMonth);
				let expiryYear = $("#expiryYear option:selected").val();
//	 			alert(expiryYear);
				if(expiryMonth=="" || expiryYear=="") {
					$("#expiryLi p").show();
				} else {
					$("#expiryLi p").hide();
				}
				let cardPassword = $("#cardPassword").val();
//	 			alert(cardPassword);
				if(cardPassword == "") {
					$("#cardPassword").addClass("input-error");
					$("#cardPassword").parent().find("p").show();
				} else {
					$("#cardPassword").removeClass("input-error");
					$("#cardPassword").parent().find("p").hide();
				}
				
				if($("#paymentAgree").hasClass("checked")) {
					$("p:contains('정기과금 이용약관에 동의해 주세요.')").hide();
				} else {
					$("p:contains('정기과금 이용약관에 동의해 주세요.')").show();
				}
			}
		});
		
		$("#payInfoUl input, #payInfoUl select").prop("disabled", true);
		
		$("#btn1").click(function() {
			$("#payInfoUl input, #payInfoUl select").prop("disabled", false);
			$("#payInfoUl").show();
			$("#kakao").hide();
			$("#A").hide();
		});
		
		$("#btn2").click(function() {
			$("#payInfoUl input, #payInfoUl select").prop("disabled", true);
			$("#payInfoUl").hide();
			$("#kakao").show();
			$("#A").hide();
		});
		
		
		
// 		$("#calculatorBtn").click(function() {
// 			alert("!");
// 			$("#paymentPopupLayer7").removeClass("disappear");
// 			$("#paymentPopup7").addClass("paymentPopup7");
// 			$("#background").addClass("paymentPopup2");
// 		});
		
		
		
		
		
	});
	
	
	
	function restrictInput(event) {
		  const inputElement = event.target;
		  const regex = /^[0-9+-]+$/; // 허용할 문자의 정규식

		  const inputValue = inputElement.value;
		  if (!regex.test(inputValue)) {
		    // 허용되지 않는 문자가 입력되었을 때 입력을 막습니다.
		    inputElement.value = inputValue.replace(/[^0-9+-]/g, '');
		  }
		}
	
</script>
<style>
	.paymentPopup{
    overflow-y: auto;
    top: 0;
    right: 0;
    bottom: 0;
    left: 0;
    background: rgba(0,0,0,.6);
/*     z-index: 12; */
    position: fixed;
    display: block;
    -ms-overflow-y: hidden;
	}
	
	.paymentPopup2 {
    overflow-y: auto;
    top: 0;
    right: 0;
    bottom: 0;
    left: 0;
    /* background: rgba(0,0,0,.6); */
    z-index: 12; 
    position: fixed;
    display: block;
    -ms-overflow-y: hidden;
}
.disappear {
	display: none;
}
.ad {
	font-size: 35px;
    margin-top: 100px;
    display: inline-block;
    padding: 20px;
    border: 1px solid #ddd;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    text-align: center;
    color: #333;
    font-weight: bold;
    font-family: Arial, sans-serif;
}
</style>
</head>
<body>
	<div id="paymentLayer" class="payment-layer-wrap d-none" style="display: block;">
		<div class="upgrade-singup-header">
		    <a href="#" class="flow-logo" style="display: block; cursor: auto;">
		        <img src="Images/with_logo.png">
		    </a>
		    <button class="button-go-back" style="display: none;">
		        <i class="ico-return"></i>
		        <span>뒤로</span>
		    </button>
		    <h2 id="paymentHeader"></h2>
		    <a id="closePayment" href="#" class="btn-close"></a>
		</div>
		
		<div class="plan-banner step2" style="display: none;"><div>
		        <p class="tit">계좌이체 또는 자동이체를 통해서도 결제할 수 있습니다.</p>
<!-- 		        <a href="#" id="autoAccountBtn">신청하기</a> -->
		    </div>
		</div>
		<div class="upgrade-version-wrap js-payment-layer pro-ver" id="businessLayer" style="display: block;">
		
		    <div class="pro-pay-wrap step1" style="display: block;">
		        <h3 class="upgrade-version-text-1">서비스 플랜 선택</h3>
		        <p id="exprDesc" class="upgrade-version-text-2">
		            <a href="https://support.flow.team/hc/ko/articles/360001697952" target="_blank" class="payment-method-link">결제 방법 알아보기</a>
		        </p>
		        <p id="payDesc" class="upgrade-version-text-2" style="display: block;"></p>
<!-- 		        <div class="gov-voucher-banner pay-plan" type="button"> -->
<!-- 		            <a href="https://sites.google.com/flow.team/2023goodchance" target="_blank"> -->
<!-- 		                <img src="/flow-renewal/homepage/flow/ko/assets/images/gov-voucher.svg" alt="정부 바우처 최대 70% 지원"> -->
<!-- 		                <p>중소기업이라면, <span>정부지원금</span>으로 플로우 이용료 지원받으세요!</p> -->
<!-- 		            </a> -->
<!-- 		        </div> -->
		        <div class="upgrade-version-section-2">
		            <div class="plans-wrap">
		                <div class="js-plan-card busi-basic" data-planid="BUSINESS_BASIC_KR_E">
		                    <div class="top">
		                        <h4 class="pp plan-name">비즈니스 베이직</h4>
		                        <p class="price-wrap">₩<span id="basicPriceYear" class="price">6,000</span></p>
		                        <p>1인/연간 계약 기준 (최소10명)<br>월간 결제 시 ₩<span id="basicPriceMonth" class="price">8,000</span></p>
		                        <p>성장하는 스타트업 또는 중소기업을 위한 상품</p>
		                        <button class="js-plan-btn" data-exp="false">요금제 선택</button>
		</div>
		                    <div class="bottom">
		                        <ul>
		                            <li>
		                                <p class="tit2">저장 공간/업로드 용량</p>
		                                <ul class="txt2">
		                                    <li>인당 20GB*인원 수</li>
		                                    <li>1회 업로드 용량 500MB</li>
		                                </ul>
		                            </li>
		                            <li>
		                                <p class="tit2">게스트 버전의 모든 기능 포함</p>
		                                <ul class="txt2">
		                                    <li>프로젝트 무제한 관리</li>
		                                    <li>간트차트</li>
		                                    <li>전체 업무, 파일 모아보기</li>
		                                    <li>Zoom 화상회의 연동</li>
		                                    <li>조직도 관리</li>
		                                </ul>
		                            </li>
		                        </ul>
		                    </div>
		                </div>
		                <div class="js-plan-card busi-pro" data-planid="BUSINESS_PRO_KR_A">
		                    <div class="banner bg-rd">추천상품</div>
		                    <div class="top">
		                        <h4 class="rd plan-name">비즈니스 프로</h4>
		                        <p class="price-wrap">₩<span id="proPriceYear" class="price">8,000</span></p>
		                        <p>1인/연간 계약 기준 (최소10명)<br>월간 결제 시 ₩<span id="proPriceMonth" class="price">10,000</span></p>
		                        <p>50인 이상의 관리 체계가 필요한 조직을 위한 상품</p>
		                        <button class="js-plan-btn" data-exp="false">요금제 선택</button>
		                    </div>
		                    <div class="bottom">
		                        <ul>
		                            <li>
		                                <p class="tit2">저장 공간/업로드 용량</p>
		                                <ul class="txt2">
		                                    <li>인당 50GB*인원 수</li>
		                                    <li>1회 업로드 용량 1GB</li>
		                                </ul>
		                            </li>
		                            <li>
		                                <p class="tit2">베이직 버전의 모든 기능 포함</p>
		                                <ul class="txt2">
		                                    <li>프로젝트 템플릿</li>
		                                    <li>보안) 2차 인증 및 중복 로그인 방지</li>
		                                    <li>보안) 모바일 장치 캡쳐 방지 설정</li>
		                                    <li>보안) 워터마크 설정</li>
		                                    <li>보안) IP 화이트리스트 - 로그인/ 파일 다운로드</li>
		                                    <li>메시지 봇 연동 - 알림 API 제공</li>
		                                    <li>맞춤화된 대시보드(예정)</li>
		                                </ul>
		                            </li>
		                        </ul>
		                    </div>
		                </div>
		                <div class="js-plan-card enter">
		                    <div class="top">
		                        <h4 class="bl">엔터프라이즈</h4>
		                        <p class="price-wrap">별도 문의</p>
		                        <p>개별계약</p>
		                        <p>전사적 협업을 위한 대기업 및 공공기관용 상품</p>
		                        <button class="js-plan-btn consult" data-exp="false">문의하기</button>
		                    </div>
		                    <div class="bottom">
		                        <ul>
		                            <li>
		                                <p class="tit2">저장 공간/업로드 용량</p>
		                                <ul class="txt2">
		                                    <li>저장 공간 협의 가능</li>
		                                    <li>1회 업로드 용량 설정 가능</li>
		                                </ul>
		                            </li>
		                            <li>
		                                <p class="tit2">프로 버전의 모든 기능 포함</p>
		                                <ul class="txt2">
		                                    <li>SSO 및 조직도 연동 지원</li>
		                                    <li>시스템 연동 지원</li>
		                                    <li>감사 로그</li>
		                                    <li>외부인 관리</li>
		                                    <li>전담 고객 담당자 지원</li>
		                                </ul>
		                            </li>
		                        </ul>
		                    </div>
		                </div>
		            </div>
		        </div>
		
		        <div class="faq-wrap">
		            <div class="textWrap">
		                <h3 class="upgrade-version-text-1">자주 묻는 질문</h3>
		            </div>
		            <ul class="faqList">
		                <li class="faqItem active">
		                    <a href="javascript:void(0);">비즈니스 베이직과 비즈니스 프로 요금제, 무엇이 다른가요? <i class="ico-arrow-99"></i></a>
		                    <div class="faqAnswer">
		                        <p>
		                            비즈니스 베이직 요금제는 플로우의 대표 기능인 프로젝트ㆍ메신저ㆍ화상회의ㆍ관리자 기능(사용자 계정관리, 조직도 관리, 사용 통계 등)이 제공됩니다.<br>
		                            비즈니스 프로 요금제는 더 안전하고 편리한 업무를 위한 로그인/파일 보안 기능, 여유로운 용량 및 다양한 업무 관리 기능(프로젝트 템플릿, OKR, OPEN API 등)이 강화된 요금제입니다.
		                        </p>
		                    </div>
		                </li>
		                <li class="faqItem">
		                    <a href="javascript:void(0);">엔터프라이즈 요금제는 무엇인가요?<i class="ico-arrow-99"></i></a>
		                    <div class="faqAnswer">
		                        <p>
		                            고객사 내부 서버 또는 독립 클라우드 공간에 설치하여 사용 가능한 On-Premise 서비스를 제공합니다. 엔터프라이즈 요금제는 고객사 보안정책을 준수하여 내부에 DB를 구성할 수 있습니다.<br>
		                            엔터프라이즈 요금제 이용을 희망하시거나, 자세한 상담을 원하시면, <a href="https://flow.team/kr/consult" title="구축형 도입문의" target="_blank">[여기]</a>를 클릭하여 문의해주시기 바랍니다.
		                        </p>
		                    </div>
		                </li>
		                <li class="faqItem">
		                    <a href="javascript:void(0);">10인 미만은 서비스를 이용할 수 없나요?<i class="ico-arrow-99"></i></a>
		                    <div class="faqAnswer">
		                        <p>
		                            사용 인원이 1인이더라도 플로우 서비스를 이용하실 수 있습니다. 단, 기본 요금제 기준 인원이 10인으로, 1~10인까지는 기본 요금제로 모두 동일하게 적용됩니다.
		                        </p>
		                    </div>
		                </li>
		                <li class="faqItem">
		                    <a href="javascript:void(0);">연간 결제를 하면 할인이 있나요? <i class="ico-arrow-99"></i></a>
		                    <div class="faqAnswer">
		                        <p>
		                            연간 결제는 1년 사용을 약정하고 선납하는 방식으로 월간 요금제 대비 약 20~25% 할인된 금액으로 이용하실 수 있습니다. 기업 내 구성원 변동이 적고 매달 결제가 번거로우신 경우에는 연간 결제를 추천해 드립니다. (단, 계약 기간 중 서비스를 해지할 경우 연간이 아닌 월간 결제의 표준 가로 월할 계산하며 수수료가 발생합니다.)
		                        </p>
		                    </div>
		                </li>
		                <li class="faqItem">
		                    <a href="javascript:void(0);">VAT(부가세)가 포함된 건가요? <i class="ico-arrow-99"></i></a>
		                    <div class="faqAnswer">
		                        <p>
		                            위 금액은 VAT(부가세) 포함되지 않은 금액입니다. 유료 결제 시 결제 예상 금액에 VAT(부가세) 10%가 합산되어 청구됩니다.
		                        </p>
		                    </div>
		                </li>
		                <li class="faqItem">
		                    <a href="javascript:void(0);">결제 이후 사용 인원 또는 요금제 변경 가능한가요? <i class="ico-arrow-99"></i></a>
		                    <div class="faqAnswer">
		                        <p>
		                            네, 변경 가능합니다. 자세한 방법은 <a href="https://support.flow.team/hc/ko/articles/17167694305817" target="_blank">[여기]</a>를 클릭하여 확인 부탁드립니다.
		                        </p>
		                    </div>
		                </li>
		                <li class="faqItem">
		                    <a href="javascript:void(0);">이용 중 구성원이 늘어나거나 줄어들면 요금은 어떻게 변경되나요?<i class="ico-arrow-99"></i></a>
		                    <div class="faqAnswer">
		                        <p>
		                            월간 결제의 경우 당월 사용한 구성원 수만큼 익월 후불 결제되는 방식으로 구성원이 추가 되었다면 정기 결제일에 자동으로 반영이 됩니다. 단, 당월에 구성원이 줄어들었다고 하여 바로 변경되지는 않고 다음 결제일부터 줄어든 구성원 수에 따라 요금이 변경되어 결제됩니다.<br>
		                            연간 결제는 구성원이 늘어나면 추가요금이 발생합니다. 발생한 추가요금은 결제팀을 통해 별도 안내됩니다. 단, 연간 결제는 선불제이기 때문에 구성원이 줄어든 만큼에 대한 환불을 제공하고 있지 않습니다. 따라서 연간 결제를 진행하실 때에는 구성원 수를 충분히 고려해 주세요.
		                        </p>
		                    </div>
		                </li>
		                <li class="faqItem">
		                    <a href="javascript:void(0);">퇴사자 발생 시 해당 계정도 사용요금에 반영되나요?<i class="ico-arrow-99"></i></a>
		                    <div class="faqAnswer">
		                        <p>
		                            이용중지 또는 삭제 처리를 한 경우, 사용 요금에 포함되지 않습니다. 만약 아직 퇴사자의 계정을 '정상' 상태로 유지해 두었다면 <a href="https://support.flow.team/hc/ko/articles/4404067811469" target="_blank">[여기]</a>를 클릭하여 '이용중지/삭제' 방법을 확인해주세요.
		                            참고로 연간 결제는 선불제이기 때문에 구성원이 줄어든 만큼에 대한 환불을 제공하고 있지 않습니다. 이에 따라 최초 계약 인원까지는 구성원을 자유롭게 추가 혹은 삭제가 가능합니다.
		
		                        </p>
		                    </div>
		                </li><li class="faqItem">
		                <a href="#">학생 또는 비영리 단체를 위한 할인 혜택이 있나요? <i class="ico-arrow-99"></i></a>
		                <div class="faqAnswer">
		                    <p>
		                        인증받은 교육기관, 학생단체, 공익재단의 경우 이용료 50% 할인 혜택을 받을 수 있습니다. 이에 해당하는 기관, 단체는 증명할 수 있는 증빙서류 제출이 필요하여 별도 문의 부탁드립니다.
		                    </p>
		                </div>
		            </li>
		                <li class="faqItem">
		                    <a href="javascript:void(0);">결제 전 견적서를 미리 받고 싶습니다. <i class="ico-arrow-99"></i></a>
		                    <div class="faqAnswer">
		                        <p>
		                            <a href="https://flow.team/kr/estimateApply" target="_blank">[여기]</a>를 클릭하시면 직접 견적서 발급이 가능합니다. 23년 이전 가입하여 이용 중인 기업에서는 별도 문의를 주시면 안내드리겠습니다.
		                        </p>
		                    </div>
		                </li>
		
		
		            </ul>
		        </div>
		
		
		    </div><div class="pro-pay-wrap step2" style="display: none;">
		        <h3 class="upgrade-version-text-1"><span class="js-plan-name">비즈니스 프로</span> 버전 결제</h3>
		        <p class="upgrade-version-text-2">요금은 매월 10일 자동 결제되며, 사용인원에 따라 결제금액이 변경될 수 있습니다.</p>
		        <a href="#" id="helpPaymentBtn" class="link">결제 도움말</a>
		        <div class="upgrade-version-section-2">
		            <section class="payment-contents">
		                <form action="" data-gtm-form-interact-id="0">
		                    <fieldset>
		                        <legend class="blind">비즈니스 베이직 버전 결제 폼</legend>
		                        <div class="payment-left">
		                            <strong class="form-tit" style="float: left;">결제방법 선택</strong>
		                            <button id="btn2" class="paymenttype" type="button" style="float: right;">
		                            	<img src="Images/payment_icon_yellow_small.png" style="height: 27px;"/>
		                            </button>
		                            <button id="btn1" class="paymenttype" type="button" style="float: right; background: #623AD6; border: 1px solid #623AD6; border-radius: 6px; font-weight: bold; color: #fff; font-size: 14px; margin-top: 2px; margin-right: 8px; height: 25px; width: 116px;">직접 카드 결제</button>
		                            <div style="clear:both;"></div>
		                            <ul id="payInfoUl" class="payment-info" style="display: none;">
		                                <li>
		                                    <label class="payment-info-title">이름</label>
		                                    <input id="userName" autocomplete="off" maxlength="30" class="payment-input" type="text" placeholder="이름을 입력해주세요" data-gtm-form-interact-field-id="0">
		                                    <p class="error-text d-none" style="display: none;">이름을 입력해주세요</p>
		                                </li>
		                                <li>
		                                    <label class="payment-info-title">이메일</label>
		                                    <input id="userEmail" class="payment-input" type="text" placeholder="helpflow@flow.team" autocomplete="off">
		                                </li>
		                                <li>
		                                    <label class="payment-info-title">전화번호</label>
		                                    <input id="phoneNum" class="payment-input js-number-input" autocomplete="off" maxlength="20" type="text" placeholder="숫자와 +,-만 입력 가능합니다" oninput="restrictInput(event)">
		                                    <p class="error-text d-none" style="display: none;">전화번호 형식이 맞지 않습니다.</p>
		                                </li>
		                                <li id="cardLi">
		                                    <label class="payment-info-title">카드번호</label>
		                                    <input id="longCardNum" autocomplete="off" class="payment-input js-number-input" type="text" maxlength="16" placeholder="카드번호를 입력하세요(15 or 16자리)" oninput="restrictInput(event)">
		                                    <p class="error-text d-none" style="display: none;">카드번호를 확인해주세요.</p>
		                                </li>
		                                <li id="expiryLi">
		                                    <label class="payment-info-title">유효기간</label>
		                                    <select id="expiryMonth" class="payment-select">
		                                        <option value="" selected="" disabled="" hidden="">MM</option>
		                                        <option value="01">01</option>
		                                        <option value="02">02</option>
		                                        <option value="03">03</option>
		                                        <option value="04">04</option>
		                                        <option value="05">05</option>
		                                        <option value="06">06</option>
		                                        <option value="07">07</option>
		                                        <option value="08">08</option>
		                                        <option value="09">09</option>
		                                        <option value="10">10</option>
		                                        <option value="11">11</option>
		                                        <option value="12">12</option>
		                                    </select>
		                                    <select id="expiryYear" class="payment-select"><option value="" selected="" disabled="" hidden="">YYYY</option><option value="2023">2023</option><option value="2024">2024</option><option value="2025">2025</option><option value="2026">2026</option><option value="2027">2027</option><option value="2028">2028</option><option value="2029">2029</option><option value="2030">2030</option><option value="2031">2031</option><option value="2032">2032</option><option value="2033">2033</option></select>
		                                    <p class="error-text d-none" style="display: none;">유효기간을 선택해 주세요.</p>
		                                </li>
		                                <li>
		                                    <label class="payment-info-title">비밀번호 앞 두자리</label>
		                                    <input id="cardPassword" class="payment-input input-type2 js-number-input" type="password" autocomplete="off" maxlength="2" data-gtm-form-interact-field-id="1" oninput="restrictInput(event)">
		                                    <span class="icon-password">● ●</span>
		                                    <p class="error-text d-none" style="display: none;">비밀번호를 확인해 주세요.</p>
		                                </li>
<!-- 		                                <li> -->
<!-- 		                                    <label class="payment-info-title">사업자번호 10자리 (법인) ㅣ 생년월일 6자리 (개인)</label> -->
<!-- 		                                    <input id="birthdayNum" class="payment-input js-number-input" type="text" autocomplete="off" placeholder="- 빼고 입력" maxlength="10"> -->
<!-- 		                                    <p class="error-text d-none" style="display: none;">사업자번호 또는 생년월일을 확인해주세요.</p> -->
<!-- 		                                </li> -->
		                            </ul>
		                            <div id="kakao" class="ad" style="display: none"><strong>카카오페이를 선택하셨습니다</strong></div>
		                            <div id="A" class="ad"><strong>결제방법을 선택해주세요</strong></div>
		                        </div>
		                        <div class="payment-right">
		                            <div class="payment-amount-wrap">
		                                <div class="payment-amount-header">
		                                    <h2><span id="version" class="js-plan-name">비즈니스 프로</span> 버전</h2>
		                                    <div class="">
		                                        <div class="payment-cycle" id="payOption" data-option="Y"><div>
		                                                연간 정기 결제
		                                                <span class="js-payment-sale payment-sale" style="display: inline-block;">약<em class="js-sale-percent">25%</em>할인</span>
		                                            </div>
		                                            <svg width="11" height="7" viewBox="0 0 8 5" fill="none">
		                                                <path d="M1 0.601562L4 3.60156L7 0.601562" stroke-linecap="round" stroke-linejoin="round"></path>
		                                            </svg>
		                                        </div>
		                                        <ul id="payOptionSelect" class="payment-cycle-group" style="display: none;">
		                                            <li id="monthSelect">
		                                                <div>월간 정기 결제</div>
		                                            </li>
		                                            <li id="yearSelect">
		                                                <div>
		                                                    연간 정기 결제
		                                                    <span class="js-payment-sale payment-sale" style="display: inline-block;">약<em class="js-sale-percent">25%</em>할인</span>
		                                                </div>
		                                            </li>
		                                        </ul>
		                                        <button id="calculatorBtn" class="calculator-button" style="display: none;"><i class="ico-calc"></i> 요금계산기
		                                        </button>
		                                    </div>
		                                </div>
		                                <div class="payment-amount-content">
		                                    <ul class="estimated-amount">
		                                        <li>
		                                            <div>사용자 수</div>
		                                            <div>
		                                                <input id="userCnt" type="text" value="<%=employee_count %>" class="users-number" autocomplete="off" disabled="">명
<!-- 		                                                <p class="tooltip-square" style="bottom: 45px;right: -30px;"> -->
<!-- 		                                                    예상금액은 현재 사용인원 기준으로 계산되며,<br> -->
<!-- 		                                                    사용 인원에 따라 결제금액이 변경될 수 있습니다.<br> -->
<!-- 		                                                    <em>10명까지 월 <em id="monthPriceMain">80,000</em>원 적용,</em><br> -->
<!-- 		                                                    <em>10명 초과 시, 인원 당 월 <em id="monthPriceSub">8,000</em>원 -->
<!-- 		                                                        적용됩니다.</em> -->
<!-- 		                                                </p> -->
		                                            </div>
		                                        </li>
		                                        <li>
		                                            <div>결제 예상 금액</div>
		                                            <div><p class="estimate-price">₩ <strong id="price">720,000</strong>
		                                                <em>/</em><em class="js-pay-gubun">연</em><em> (vat별도)</em>
		                                                </p><p class="orange">
		                                                    연간 결제 시, 연
		                                                    <span id="savings">240,000</span>원을 절약할 수 있습니다.
		                                                </p>
		                                            </div>
		                                        </li>
		                                    </ul>
		                                    <div class="payment-agree check-box-wrap">
		                                        <i id="paymentAgree" class="check-box"></i><span class="payment-agree-text">
		                                            <a id="termsOfServiceBtn" href="#">정기과금 이용약관</a>
		                                            내용을 확인하였고, 이에 동의합니다.
		                                        </span>
		                                    </div>
		                                    <p class="error-text d-none" style="display: none;">정기과금 이용약관에 동의해 주세요.</p>
		                                    <button type="button" class="payment-button" id="submitPayment">정기결제 신청</button>
<!-- 		                                    <button class="gov-voucher-banner pay-btn" type="button"> -->
<!-- 		                                        <a href="https://sites.google.com/flow.team/2023goodchance" target="_blank"> -->
<!-- 		                                            <img src="/flow-renewal/homepage/flow/ko/assets/images/logo_gov_cir.svg" alt="정부 로고"> -->
<!-- 		                                            <p><span>정부지원금으로</span> 결제 신청하기</p> -->
<!-- 		                                        </a> -->
<!-- 		                                    </button> -->
		                                </div>
		                            </div>
		                            <div class="payment-description"><i class="ico-security"></i>결제정보는 암호화하여 안전하게 전송되며, 서버에 저장되지 않습니다.</div>
		                        </div>
		                    </fieldset>
		                </form>
		            </section>
		        </div>
		    </div><div class="pro-pay-wrap step3" style="display: none;">
		        <h3 class="upgrade-version-text-1"><span class="js-plan-name">비즈니스 프로</span> 버전 구매 완료</h3>
		        <img src="/flow-renewal/assets/images/none_member.png" alt="/">
		        <div class="txt">
		            <p><span class="js-plan-name">비즈니스 프로</span> 버전 시작을 환영합니다</p>
		            <p class="js-is-exp">직원들을 초대하여 협업을 시작하세요!</p>
		        </div>
		        <div class="url-area">
		            <span class="invite-url js-is-exp">https://mcheck.flow.team</span>
		            <button type="button" class="copy-url-button js-is-exp">URL 복사</button>
		            <button class="js-to-main-btn">바로 시작하기</button>
		        </div>
		        <p class="caution js-is-exp">
		            30일간 무료로 이용 가능하며, 계속 이용하시려면 결제 정보 등록이 필요합니다.<br>
		            <em class="rd">기간 초과 시, 서비스 이용이 중지됩니다.</em>
		        </p>
		    </div></div>
		
		<div class="upgrade-version-wrap d-none js-payment-layer" id="freelancerLayer" style="display: none;">
		    <p class="upgrade-version-text-1">결제수단 변경</p>
		    <p class="upgrade-version-text-2">결제수단으로 사용할 카드 정보를 입력해 주세요.</p>
		    <p class="upgrade-version-text-3">카드 확인을 위해 1,000원 결제 후 취소됩니다.</p>
		    <div class="upgrade-version-section-2">
		        <section class="payment-contents">
		            <form action="">
		                <fieldset>
		                    <legend class="blind">비즈니스 베이직 버전 결제 폼</legend>
		                    <div class="payment-left payment-change">
		                        <ul id="freePaymentUl" class="payment-info">
		                            <li>
		                                <label class="payment-info-title">이름</label>
		                                <input id="userName" class="payment-input" type="text" placeholder="이름을 입력하세요" autocomplete="off">
		                                <p class="error-text d-none">이름을 확인해주세요</p>
		                            </li>
		                            <li>
		                                <label class="payment-info-title">이메일</label>
		                                <input id="userEmail" class="payment-input" type="text" placeholder="helpflow@flow.team" autocomplete="off">
		                            </li>
		                            <li>
		                                <label class="payment-info-title">전화번호</label>
		                            <input id="phoneNum" class="payment-input js-number-input" maxlength="20" type="text" autocomplete="off" placeholder="전화번호(숫자와 +,-만 입력 가능합니다)">
		                                <p class="error-text d-none">전화번호 형식이 맞지 않습니다.</p>
		                            </li>
		                            <li id="cardLi">
		                                <label class="payment-info-title">카드번호</label>
		                                <input id="cardNum1" class="payment-input input-type2 js-number-input" type="text" autocomplete="off" maxlength="4">
		                                <input id="cardNum2" class="payment-input input-type2 js-number-input" type="text" autocomplete="off" maxlength="4">
		                                <input id="cardNum3" class="payment-input input-type2 js-number-input" type="text" autocomplete="off" maxlength="4">
		                                <input id="cardNum4" class="payment-input input-type2 js-number-input" type="text" autocomplete="off" maxlength="4">
		                                <p class="error-text d-none">카드번호를 확인해주세요.</p>
		                            </li>
		                            <li id="expiryLi">
		                                <label class="payment-info-title">유효기간</label>
		                                <select id="expiryMonth" class="payment-select">
		                                    <option value="" selected="" disabled="" hidden="">MM</option>
		                                    <option value="01">01</option>
		                                    <option value="02">02</option>
		                                    <option value="03">03</option>
		                                    <option value="04">04</option>
		                                    <option value="05">05</option>
		                                    <option value="06">06</option>
		                                    <option value="07">07</option>
		                                    <option value="08">08</option>
		                                    <option value="09">09</option>
		                                    <option value="10">10</option>
		                                    <option value="11">11</option>
		                                    <option value="12">12</option>
		                                </select>
		                                <select id="expiryYear" class="payment-select">
		                                    <option value="" selected="" disabled="" hidden="">YYYY</option>
		                                    <option value="2021">2021</option>
		                                    <option value="2022">2022</option>
		                                    <option value="2023">2023</option>
		                                    <option value="2024">2024</option>
		                                    <option value="2025">2025</option>
		                                </select>
		                                <p class="error-text d-none">유효기간을 선택해 주세요.</p>
		                            </li>
		                            <li>
		                                <label class="payment-info-title">비밀번호 앞 두자리</label>
		                                <input id="cardPassword" class="payment-input input-type2 js-number-input" type="text" autocomplete="off" maxlength="2">
		                                <span class="icon-password">● ●</span>
		                                <p class="error-text d-none">비밀번호를 확인해 주세요.</p>
		                            </li>
		                            <li>
		                                <label class="payment-ㄹinfo-title">사업자번호 10자리 (법인) ㅣ 생년월일 6자리 (개인)</label>
		                                <input id="birthdayNum" autocomplete="off" class="payment-input js-number-input" type="text" placeholder="- 빼고 입력" maxlength="10">
		                                <p class="error-text d-none">사업자번호 또는 생년월일을 확인해주세요.</p>
		                            </li>
		                            <li>
		                                <label class="payment-info-title">추천인 입력<span>필수 입력사항은 아닙니다.</span></label>
		                                <input type="text" id="recommendId" class="payment-input" autocomplete="off" placeholder="아이디 또는 이메일 주소 입력">
		                            </li>
		                        </ul>
		                        <div class="join-check js-join-check">
		                            <input id="paymentConfirmCheck" type="checkbox" class="js-confirm-input confirm-input">
		                            <label for="paymentConfirmCheck" class="js-confirm-check"></label>
		                            <span class="payment-agree-text">
		                                <a id="termsOfServiceBtn" href="#">정기과금 이용약관</a> 내용을 확인하였고, 이에 동의합니다.
		                            </span>
		                            <p class="error-text d-none">정기과금 이용약관에 동의해 주세요.</p>
		                        </div>
		                        <button type="button" class="payment-button" id="submitPayment">결제수단 변경</button>
		                        </div>
		                </fieldset>
		            </form>
		            <p class="payment-description">결제정보는 암호화하여 안전하게 전송되며, 서버에 저장되지 않습니다.</p>
		        </section>
		    </div>
		</div>
		
		<div id="paymentConsult" class="flow-apps-payment popup banner-notice-wrap js-payment-consult" style="display: none;">
		    <div class="payment-popup qna">
		        <div class="payment-popup-header">
		            <b>서비스 업그레이드</b>
		            <button class="payment-back js-consult-close">
		                <i class="icon-payment-x-off"></i>
		            </button>
		        </div>
		        <div class="popup-qna">
		            <p>아래의 항목을 남겨주시면, 유선상담 후 비즈니스 프로를 시작할 수 있습니다.</p>
		            <textarea id="paymentConsultTxt" placeholder="안내받으실 연락처와 문의내용을 입력해주세요."></textarea>
		            <div class="flow-pop-button-type-1">
		                <button class="flow-pop-sub-button-1 js-consult-close">취소</button>
		                <button id="paymentConsultSubmit" class="agree-use bg-pp">신청하기</button>
		            </div>
		        </div>
		    </div>
		</div>
		<div id="waitPaymentPopup" class="flow-all-background-1 d-none">
		    <div class="flow-project-make-1">
		        <div class="flow-project-make-2">
		            <div class="loading-popup flow-project-popup-6">
		                <div class="flow-content">
		                    <div class="flow-content-text">
		                        <p class="popup-cont">결제 진행 중 입니다.<br>잠시만 기다려 주세요</p>
		                    </div>
		                    <div class="loading">
		                        <i class="circle"></i>
		                        <i class="circle"></i>
		                        <i class="circle"></i>
		                        <i class="circle"></i>
		                    </div>
		                </div>
		            </div>
		        </div>
		    </div>
		</div>
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		<div id="paymentPopup" tabindex="-1" class="flow-all-background-1 d-none payment-popup">
		    <div class="flow-project-make-1">
		        <div class="flow-project-make-2">
		            <div id="paymentPopupLayer" class="popup-wr">
		                <div class="popup-tit">
		                    <strong id="popupTitle" class="section-tit">요금 계산기</strong>
		                    <button id="closeBtn" class="btn-close">
		                        <i class="icons-close-1"></i>
		                    </button>
		                </div>
		                <div id="content">
		                </div>
		            </div>
		        </div>
		    </div>
		</div>
		
		<div id="paymentPopupContent" class="d-none">
		    <div class="js-calculator-item">
		        <div class="payment-section">
		            <strong class="section-tit">결제주기</strong>
		            <div class="payment-cycle" id="calPayOption" data-option="Y">연간 정기 결제<span class="js-payment-sale payment-sale" style="display: inline-block;">20% 할인</span></div>
		            <ul id="calOptionSelect" class="payment-cycle-group" style="display: none;">
		                <li id="yearSelect">
		                    <div>연간 정기 결제<span class="js-payment-sale payment-sale" style="display: inline-block;">20% 할인</span></div>
		                </li>
		                <li id="monthSelect">
		                    <div>월간 정기 결제</div>
		                </li>
		            </ul>
		        </div>
		        <div class="payment-section">
		            <strong class="section-tit">예상금액</strong>
		            <table class="payment-bill">
		                <tbody>
		                <tr>
		                    <td>
		                        현재 사용인원
		                    </td>
		                    <td>
		                        <input id="calUserCnt" type="text" maxlength="4" value="10">
		                        <span>명</span>
		                    </td>
		                </tr>
		                <tr>
		                    <td>
		                        예상 결제금액
		                    </td>
		                    <td>
		                        <input id="calPrice" type="text" value="₩600,000" readonly="readonly">
		                        <span class="js-cal-gubun"> /년</span><span class="vat-text">(VAT 별도)</span>
		                    </td>
		                </tr>
		                <tr>
		                    <td>
		                        <i class="icon-idea"></i>
		                        절약금액
		                    </td>
		                    <td>
		                        <input id="calSavings" type="text" value="₩120,000" readonly="readonly">
		                        <span class="js-cal-gubun"> /년</span><span class="vat-text">(VAT 별도)</span>
		                    </td>
		                </tr>
		                </tbody>
		            </table>
		            <p class="alert-txt">매월 사용 인원수에 따라 이용 금액이 변경 될 수 있습니다.</p>
		        </div>
		        <button class="btn-qna js-question-btn">
		            <i></i>
		            자주묻는 질문 보기
		        </button>
		        
		        <a class="payment-go-button" target="_blank" href="/estimateapply.act">견적서 요청</a>
		        
		    </div>
		    <div class="js-tearm-of-service-item">
		        <div class="agreement-section">
		            <strong>과금 정책</strong>
		            <ul class="agreement-contents">
		                <li>・ 선택한 요금제에 따라서 월간 혹은 연간 과금 형태로 결제가 진행됩니다.</li>
		                <li>・ 정확한 결제 정보를 입력하셔야 하며, 결제 정보를 제공할 경우 플로우(또는 플로우가 지정한 결제 대행업체)가 해당 거래에 필요한 결제 금액 전체를 청구할 수 있도록 허가한
		                    것으로 간주합니다. 부가세는 별도로 부과됩니다.
		                </li>
		                <li>・ 별도의 취소 의사가 없는 한, 선택한 요금제에 과금이 진행됩니다. 취소 시, 결제 중단 처리가 되며 청구할 금액이 남아 있다면 다음 달에 과금이 청구됩니다.</li>
		                <li>・ 이미 지불이 완료된 금액에 대해서는 환불이 불가합니다. 단, 플로우의 귀책사유로 인해 잘못된 금액이 결제되었거나 초과 과금이 발생한 경우 환불이 가능합니다.</li>
		            </ul>
		            <br>
		            <strong>월간 과금</strong>
		            <ul class="agreement-contents">
		                <li>・ 매달 정기적으로 전월 사용금액에 대해서 결제가 진행됩니다. 기본요금 이외에 등록된 매월 최대 사용 인원을 기준으로 추가요금이 산정됩니다. 월간 과금에서 연간 과금으로 전환을
		                    지원하지 않습니다.
		                </li>
		            </ul>
		            <br>
		            <strong>연간 과금</strong>
		            <ul class="agreement-contents">
		                <li>・ 연간 사용금액에 대해서 선결제가 진행됩니다. 기본요금 이외에 등록된 사용 인원을 기준으로 추가요금이 산정됩니다.</li>
		                <li>・ 연간 과금에서 월간 과금으로 전환을 지원하지 않으며, 사용 인원이 감소한 경우 해당 요금에 대해서 환불 처리되지 않습니다.</li>
		                <li>・ 연간 과금 결제 이후 사용 인원이 결제 기준 인원에서 추가될 경우 인원 당 추가 요금을 청구합니다. 추가된 사용 인원에 대한 결제 금액은 사용 인원이 감소하더라도 해당 요금에
		                    대해 환불 처리되지 않습니다.
		                </li>
		                <li>
		                    ・ 추가 인원 계산 공식은 아래와 같습니다. <br>
		                    (1) 추가된 사용 인원 X 연간 요금제 월 요금 X 남은 기간
		                </li>
		                <li>・ 추가된 사용 인원에 대한 결제 금액은 사용 인원이 감소하더라도 해당 요금에 대해 환불 처리되지 않습니다.</li>
		                <li>・ 연간 과금으로 결제 시, 계약 기간 중 서비스 탈퇴 시 위약금이 발생합니다. 위약금은 "월간과금 대비 할인받은 금액 + 남은 기간 동안 지불할 금액의 10%"이며, 위약금에는
		                    Tax가 부과되지 않습니다.
		                </li>
		                <li>
		                    ・ 월간 과금 대비 할인 받은 금액은 연간 과금 계약 시 체결한 월 청구금액 기준으로 계산되며, 남은 기간 동안 지불할 금액의 10%는 서비스 탈퇴 신청일부터 이전 30일 동안
		                    최대 사용 인원 기준으로 계산됩니다. <br>
		                    위약금 계산 공식은 아래와 같습니다. <br>
		                    (1) 월간 과금 요금제 대비 할인 받은 금액 = {사용기간 월 X (월간과금제월요금 - 연간과금제월요금)}<br>
		                    (2) 남은 기간 동안 지불할 금액의 10% = {연간과금제 월계약금액 X (총계약기간 월-사용기간 월)+(추가 사용 인원 사용금액)} X 10%<br>
		                    (3) 위약금 = (1) + (2)
		                </li>
		            </ul>
		            <br>
		            <strong>결제 실패</strong>
		            <ul class="agreement-contents">
		                <li>・ 결제 시점에 결제가 실패하면 이후 2회까지 재결제를 시도하고 이후에도 결제에 실패하면 서비스 이용을 중지합니다.</li>
		                <li>・ "고객"은 미납액이 발생하는 경우 납부의 의무가 있으며 미납이 30일 이상 지속될 경우 서비스에 제한이 있을 수 있습니다. 미납액에 대한 포기 및 취소는 가능하지 않으며,
		                    이용료 지불에 대한 납세의 책임 또한 "고객"에게 있습니다.
		                </li>
		            </ul>
		            <br>
		            <strong>기타</strong>
		            <ul class="agreement-contents">
		                <li>・ 플로우가 지정한 결제 대행업체는 결제 처리를 위해 제공해 주신 결제 정보를 수집 및 저장할 수 있으며, 결제 정보는 결제 외 다른 용도로 사용되지 않습니다. 취소 관련 문의는
		                    <a class="payment-popup-link" href="mailto:support@flow.team">support@flow.team </a>또는 1:1
		                    문의하기를 통해 가능합니다.
		                </li>
		            </ul>
		
		            <ul class="agreement-contents">
		                <li>・ 본 약관에 명시되지 않은 내용은 플로우 <a class="payment-popup-link" href="/terms.act" target="serviceTerms">서비스
		                    이용약관</a> 및 <a class="payment-popup-link" href="/privacy.act" target="flowPrivacy">개인정보 처리방침</a>을 따릅니다.
		                </li>
		                <li>・ 시행일 : 2022년 05월 25일</li>
		            </ul>
		        </div>
		    </div>
		    <div class="js-account-item">
		        <ul class="account-contents">
		            <li>
		                <i class="icon-mail"></i>
		                <a href="mailto:support@flow.team">support@flow.team</a>
		            </li>
		            <li>
		                <p>아래의 서류를 준비하여 메일로 보내주세요.</p>
		                <button class="btn-qna js-question-btn">
		                    <i></i>
		                    자주묻는 질문 보기
		                </button>
		            </li>
		            <li>
		                <strong>계좌이체</strong>
		                <span class="dot">사업자등록증</span>
		            </li>
		            <li>
		                <strong>자동이체</strong>
		                <span class="dot">사업자등록증</span>
		                <span class="dot">
		                            자동출금신청 동의서
		                            <button id="autoAccountDownload" class="btn-download">
		                                <i class="icons-download"></i>
		                                다운로드
		                            </button>
		                        </span>
		            </li>
		        </ul>
		    </div>
		</div>
		
		
	</div>
	
	
	
	
	<div id="background" class="">
	<div id="paymentPopup7" class="">
	</div>
		<div id="paymentPopupLayer7" class="popup-wr disappear">
                <div class="popup-tit">
                    <strong id="popupTitle" class="section-tit">요금 계산기</strong>
                </div>
                <div id="content">
        <div class="payment-section">
            <strong class="section-tit">결제주기</strong>
            <div class="payment-cycle" id="calPayOption" data-option="Y">연간 정기 결제<span class="js-payment-sale payment-sale" style="display: inline-block;">25% 할인</span></div>
            <ul id="calOptionSelect" class="payment-cycle-group">
                
                <li id="yearSelect">
                    <div>연간 정기 결제<span class="js-payment-sale payment-sale" style="display: inline-block;">25% 할인</span></div>
                </li><li id="monthSelect">
                    <div>월간 정기 결제</div>
                </li>
                
            </ul>
        </div>
        <div class="payment-section">
            <strong class="section-tit">예상금액</strong>
            <table class="payment-bill">
                <tbody>
                <tr>
                    <td>
                        현재 사용인원
                    </td>
                    <td>
                        <input id="calUserCnt" type="text" maxlength="4" value="10">
                        <span>명</span>
                    </td>
                </tr>
                <tr>
                    <td>
                        예상 결제금액
                    </td>
                    <td>
                        <input id="calPrice" type="text" value="₩720,000" readonly="readonly">
                        <span class="js-cal-gubun"> / 연</span><span class="vat-text">(VAT 별도)</span>
                    </td>
                </tr>
                <tr>
                    <td>
                        <i class="icon-idea"></i>
                        절약금액
                    </td>
                    <td>
                        <input id="calSavings" type="text" value="₩240,000" readonly="readonly" style="color: #fa6c3f;">
                        <span class="js-cal-gubun"> / 연</span><span class="vat-text">(VAT 별도)</span>
                    </td>
                </tr>
                </tbody>
            </table>
            <p class="alert-txt">매월 사용 인원수에 따라 이용 금액이 변경 될 수 있습니다.</p>
        </div>
        <button class="btn-qna js-question-btn">
            <i></i>
            자주묻는 질문 보기
        </button>
        
        
    </div>
            </div>
            </div>
	
	
	
</body>
</html>