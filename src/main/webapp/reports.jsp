<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reports</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 20px;
        }
        .container {
            max-width: 800px;
            margin: 50px auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            color: #333;
        }
        .report-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            margin: 20px 0;
            padding: 20px;
            border-radius: 8px;
            color: white;
        }
        .report-card h3 {
            margin-top: 0;
        }
        button {
            background: white;
            color: #667eea;
            padding: 8px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
        }
        .date-inputs {
            margin-top: 10px;
            display: none;
        }
        .date-inputs.active {
            display: block;
        }
        .date-inputs input {
            margin: 5px;
            padding: 5px;
        }
        .back-link {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: #667eea;
            text-decoration: none;
        }
    </style>
    <script>
        function toggleDates(reportType) {
            document.getElementById('unpaidDates').classList.remove('active');
            document.getElementById('collectionDates').classList.remove('active');
            
            if(reportType === 'overdue') {
                document.getElementById('overdueForm').submit();
            } else if(reportType === 'unpaid') {
                document.getElementById('unpaidDates').classList.add('active');
            } else if(reportType === 'collection') {
                document.getElementById('collectionDates').classList.add('active');
            }
        }
        
        function submitReport(reportType) {
            if(reportType === 'overdue') {
                document.getElementById('overdueForm').submit();
            } else if(reportType === 'unpaid') {
                document.getElementById('unpaidForm').submit();
            } else if(reportType === 'collection') {
                document.getElementById('collectionForm').submit();
            }
        }
    </script>
</head>
<body>
    <div class="container">
        <h2>Generate Reports</h2>
        
        <div class="report-card">
            <h3>📊 Overdue Payments</h3>
            <p>View all students with overdue payments</p>
            <form id="overdueForm" action="ReportServlet" method="post">
                <input type="hidden" name="reportType" value="overdue">
                <button type="button" onclick="submitReport('overdue')">Generate</button>
            </form>
        </div>
        
        <div class="report-card">
            <h3>📅 Unpaid Students</h3>
            <p>Students who haven't paid in a period</p>
            <button onclick="toggleDates('unpaid')">Select Date Range</button>
            <div id="unpaidDates" class="date-inputs">
                <form id="unpaidForm" action="ReportServlet" method="post">
                    <input type="hidden" name="reportType" value="unpaid">
                    <input type="date" name="startDate" required>
                    <input type="date" name="endDate" required>
                    <button type="submit">Generate</button>
                </form>
            </div>
        </div>
        
        <div class="report-card">
            <h3>💰 Total Collection</h3>
            <p>Total fee collection over a period</p>
            <button onclick="toggleDates('collection')">Select Date Range</button>
            <div id="collectionDates" class="date-inputs">
                <form id="collectionForm" action="ReportServlet" method="post">
                    <input type="hidden" name="reportType" value="collection">
                    <input type="date" name="startDate" required>
                    <input type="date" name="endDate" required>
                    <button type="submit">Generate</button>
                </form>
            </div>
        </div>
        
        <a href="index.jsp" class="back-link">← Back to Menu</a>
    </div>
</body>
</html>