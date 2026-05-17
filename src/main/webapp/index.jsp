<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>College Fee Payment System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            margin: 0;
            padding: 0;
            min-height: 100vh;
        }
        .container {
            max-width: 1200px;
            margin: 50px auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
        }
        .menu {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-top: 30px;
        }
        .menu-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 30px;
            border-radius: 10px;
            text-align: center;
            transition: transform 0.3s;
            cursor: pointer;
        }
        .menu-card:hover {
            transform: translateY(-5px);
        }
        .menu-card a {
            color: white;
            text-decoration: none;
            font-size: 18px;
            font-weight: bold;
            display: block;
        }
        .menu-card p {
            color: white;
            margin-top: 10px;
            font-size: 14px;
        }
        .footer {
            text-align: center;
            margin-top: 40px;
            padding-top: 20px;
            border-top: 1px solid #eee;
            color: #666;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🏫 College Fee Payment System</h1>
        <div class="menu">
            <div class="menu-card">
                <a href="feepaymentadd.jsp">💰 Add Fee Payment</a>
                <p>Record new fee payment transactions</p>
            </div>
            <div class="menu-card">
                <a href="feepaymentupdate.jsp">✏️ Update Payment</a>
                <p>Modify existing payment records</p>
            </div>
            <div class="menu-card">
                <a href="feepaymentdelete.jsp">🗑️ Delete Payment</a>
                <p>Remove payment records</p>
            </div>
            <div class="menu-card">
                <a href="DisplayFeePaymentsServlet">📋 View All Payments</a>
                <p>Display all payment records</p>
            </div>
            <div class="menu-card">
                <a href="reports.jsp">📊 Reports</a>
                <p>Generate various reports</p>
            </div>
        </div>
        <div class="footer">
            <p>&copy; 2024 College Fee Management System</p>
        </div>
    </div>
</body>
</html>