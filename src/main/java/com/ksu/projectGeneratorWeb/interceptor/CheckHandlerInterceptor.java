package com.ksu.projectGeneratorWeb.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

/**
 * http拦截器
 * @author jinliang jinliang@lingqianpay.com 
 * 2013-12-24
 *
 */
public class CheckHandlerInterceptor implements HandlerInterceptor{

	public void afterCompletion(HttpServletRequest request,HttpServletResponse response, Object obj, Exception exception)throws Exception {
		
		
	}

	public void postHandle(HttpServletRequest request, HttpServletResponse response,Object obj, ModelAndView mav) throws Exception {
		
		
	}

	public boolean preHandle(HttpServletRequest request, HttpServletResponse response,Object handler) throws Exception {
		/*HttpSession session = request.getSession();
		String url=request.getRequestURL().toString();
		if(url.endsWith("logon")){
			return true;
		}
		if(session.getAttribute("user")!=null){
			return true;
		}else{
			request.setAttribute("result", "reLogin");
			request.getRequestDispatcher("/pages/login/result.jsp").forward(request, response);  
			return false;
		}*/
		
		return true;
	}

}
