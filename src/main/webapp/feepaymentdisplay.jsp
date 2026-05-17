<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.model.FeePayment, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>All Fee Payments</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 20px;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            border-radius: 15px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            overflow-x: auto;
        }
        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px;
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #e0e0e0;
        }
        th {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            font-weight: 600;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        .status-paid {
            color: #28a745;
            font-weight: bold;
        }
        .status-overdue {
            color: #dc3545;
            font-weight: bold;
        }
        .back-link {
            display: inline-block;
            margin: 20px;
            color: #667eea;
            text-decoration: none;
            font-weight: bold;
        }
        .no-data {
            text-align: center;
            padding: 40px;
            color: #666;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>All Fee Payment Records</h1>
            <p>Complete list of all fee transactions</p>
        </div>
        <%
            List<FeePayment> payments = (List<FeePayment>) request.getAttribute("payments");
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        %>
        <table>
            <thead>
                <tr>
                    <th>Payment ID</th>
                    <th>Student ID</th>
                    <th>Student Name</th>
                    <th>Payment Date</th>
                    <th>Amount</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <% if(payments != null && !payments.isEmpty()) {
                    for(FeePayment payment : payments) { %>
                        <tr>
                            <td><%= payment.getPaymentId() %></td>
                            <td><%= payment.getStudentId() %></td>
                            <td><%= payment.getStudentName() %></td>
                            <td><%= sdf.format(payment.getPaymentDate()) %></td>
                            <td>₹<%= payment.getAmount() %></td>
                            <td class="status-<%= payment.getStatus().toLowerCase() %>">
                                <%= payment.getStatus() %>
                            </td>
                        </tr>
                    <% }
                } else { %>
                    <tr>
                        <td colspan="6" class="no-data">No payment records found</td>
                    </tr>
                <% } %>
            </tbody>
        </table>
        <a href="index.jsp" class="back-link">← Back to Menu</a>
    </div>
</body>
</html>