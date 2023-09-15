<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.time.ZoneId"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<fmt:setLocale value="ja_JP" />

<%!private static Map eventMap = new HashMap();
	static {
		eventMap.put("20230101", "お正月");
		eventMap.put("20230109", "成人の日");
		eventMap.put("20230203", "節分");
		eventMap.put("20230210", "春節");
		eventMap.put("20230211", "建国記念日　初午いなりの日");
		eventMap.put("20230214", "St.Valentine's day");
		eventMap.put("20230222", "猫の日");
		eventMap.put("20230223", "天皇誕生日、富士山の日");
		eventMap.put("20230303", "ひな祭り");
		eventMap.put("20230306", "世界一周の日");
		eventMap.put("20230308", "International Women’s Day");
		eventMap.put("20230321", "春分の日");
		eventMap.put("20230429", "昭和の日");
		eventMap.put("20230503", "憲法記念日");
		eventMap.put("20230504", "みどりの日");
		eventMap.put("20230505", "子どもの日");
		eventMap.put("20230514", "母の日");
		eventMap.put("20230610", "時の記念日");
		eventMap.put("20230618", "父の日");
		eventMap.put("20230630", "夏越大祭");
		eventMap.put("20230707", "七夕");
		eventMap.put("20230717", "海の日");
		eventMap.put("20230730", "土用の丑の日");
		eventMap.put("20230805", "発行の日");
		eventMap.put("20230806", "広島原爆の日");
		eventMap.put("20230809", "長崎原爆の日");
		eventMap.put("20230811", "山の日");
		eventMap.put("20230829", "焼き肉の日");
		eventMap.put("20230901", "防災の日");
		eventMap.put("20230903", "宇宙の日");
		eventMap.put("20230918", "敬老の日");
		eventMap.put("20230923", "秋分の日");
		eventMap.put("20231009", "スポーツの日");
		eventMap.put("20231103", "文化の日");
		eventMap.put("20231120", "教師の日");
		eventMap.put("20231123", "Thanksgiving Day　新嘗祭");
		eventMap.put("20231231", "大晦日");
	}%>

<%
// リクエストのパラメーターから日付を取り出す
String year = (String) request.getParameter("year");
String month = (String) request.getParameter("month");
String day = (String) request.getParameter("day");
LocalDate localDate = null;

if (year == null || month == null || day == null) {
	// 日付が送信されていないので、現在時刻を元に日付の設定を行う
	localDate = LocalDate.now();
	year = String.valueOf(localDate.getYear());
	month = String.valueOf(localDate.getMonthValue());
	day = String.valueOf(localDate.getDayOfMonth());
} else {
	// 送信された日付を元に、LocalDateのインスタンスを生成する
	localDate = LocalDate.of(Integer.parseInt(year), Integer.parseInt(month), Integer.parseInt(day));
}
String[] dates = { year, month, day };

// 画面で利用するための日付、イベント情報を保存
session.setAttribute("dates", dates);
session.setAttribute("date", Date.from(localDate.atStartOfDay(ZoneId.systemDefault()).toInstant()));

String event = (String) eventMap.get(year + month + day);
session.setAttribute("event", event);
%>

<!DOCTYPE HTML>
<html>
<head>
<meta charset="UTF-8">
<title>calendar</title>

<style>
ul {
	list-style: none;
}
</style>
</head>

<body>
	<form method="POST" action="/jsp/calendar.jsp">
		<ul>
			<li><input type="text" name="year"
				value="<c:out value="${param.year}" />" /><label for="year">年</label><input
				type="text" name="month" value="<c:out value="${param.month}" />" /><label
				for="month">月</label><input type="text" name="day"
				value="<c:out value="${param.day}" />" /><label for="day">日</label></li>
			<li><input type="submit" value="送信" />
			<li><c:out value="${fn:join(dates, '/')}" /> (<fmt:formatDate
					value="${date}" pattern="E" />)</li>
			<li><c:out value="${event}" /></li>


		</ul>
	</form>
</body>
</html>
