package com.servlet;

import com.dao.FeePaymentDAO;
import com.model.FeePayment;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/ReportServlet")
public class ReportServlet extends HttpServlet {
    private FeePaymentDAO feePaymentDAO;
    
    public void init() {
        feePaymentDAO = new FeePaymentDAO();
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String reportType = request.getParameter("reportType");
        
        try {
            if ("overdue".equals(reportType)) {
                List<FeePayment> overdueList = feePaymentDAO.getOverduePayments();
                request.setAttribute("reportData", overdueList);
                request.setAttribute("reportTitle", "Students with Overdue Payments");
                
            } else if ("unpaid".equals(reportType)) {
                String startDate = request.getParameter("startDate");
                String endDate = request.getParameter("endDate");
                List<FeePayment> unpaidList = feePaymentDAO.getUnpaidInPeriod(startDate, endDate);
                request.setAttribute("reportData", unpaidList);
                request.setAttribute("reportTitle", "Students Who Haven't Paid (Period: " + startDate + " to " + endDate + ")");
                
            } else if ("collection".equals(reportType)) {
                String startDate = request.getParameter("startDate");
                String endDate = request.getParameter("endDate");
                BigDecimal total = feePaymentDAO.getTotalCollection(startDate, endDate);
                request.setAttribute("totalCollection", total);
                request.setAttribute("startDate", startDate);
                request.setAttribute("endDate", endDate);
                request.setAttribute("reportTitle", "Total Fee Collection Report");
            }
            
            request.getRequestDispatcher("report_result.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error generating report: " + e.getMessage());
            request.getRequestDispatcher("reports.jsp").forward(request, response);
        }
    }
}