<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.model.FeePayment, java.math.BigDecimal, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Report Result</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 20px;
        }
        .container {
            max-width: 1000px;
            margin: 20px auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        .total {
            font-size: 24px;
            text-align: center;
            color: #28a745;
            font-weight: bold;
            margin-top: 20px;
        }
        .back-link {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: #667eea;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2><%= request.getAttribute("reportTitle") %></h2>
        
        <% if(request.getAttribute("reportData") != null) { 
            List<FeePayment> data = (List<FeePayment>) request.getAttribute("reportData");
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
                    <% for(FeePayment payment : data) { %>
                        <tr>
                            <td><%= payment.getPaymentId() %></td>
                            <td><%= payment.getStudentId() %></td>
                            <td><%= payment.getStudentName() %></td>
                            <td><%= sdf.format(payment.getPaymentDate()) %></td>
                            <td>₹<%= payment.getAmount() %></td>
                            <td><%= payment.getStatus() %></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        <% } else if(request.getAttribute("totalCollection") != null) { 
            BigDecimal total = (BigDecimal) request.getAttribute("totalCollection");
            String startDate = (String) request.getAttribute("startDate");
            String endDate = (String) request.getAttribute("endDate");
        %>
            <div class="total">
                Total Collection from <%= startDate %> to <%= endDate %>: ₹<%= total %>
            </div>
        <% } %>
        
        <a href="reports.jsp" class="back-link">← Back to Reports</a>
    </div>
</body>
</html>