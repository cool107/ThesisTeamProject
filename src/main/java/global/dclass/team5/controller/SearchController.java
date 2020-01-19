package global.dclass.team5.controller;

import java.io.FileInputStream;
import java.util.ArrayList;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import global.dclass.team5.VO.SearchedResult;
import global.dclass.team5.VO.Thesis;
import global.dclass.team5.service.SearchService;

@Controller
public class SearchController {

	private static final String UPLOADPATH = "D:/Users/dud54/Desktop/DATA/K-move/36기 D반 5조 프로젝트/Project/ThesisManagementSystem/src/main/webapp/resources/finalFile/";
	
	@Autowired
	SearchService service;
	
	@RequestMapping(value="goSelectSearchForm", method=RequestMethod.GET)
	public String goSelectSearchForm() {
		return "/search/selectSearchForm";
	}
	
	@RequestMapping(value="goUniversityThesisForm", method=RequestMethod.GET)
	public String goUniversityThesisForm() {
		return "/search/universityThesisForm";
	}
	
	@RequestMapping(value = "goSearchForm", method = RequestMethod.GET)
	public String goSearchForm() {
		return "/search/searchForm";
	}

	@RequestMapping(value = "search_bar", method = RequestMethod.GET)
	public String searchThesis() {
		return "/search/searchForm";
	}

	// 논문 검색
	@ResponseBody
	@RequestMapping(value = "searchForm_first", method = RequestMethod.POST)
	public String searhthesis(@RequestBody ArrayList<SearchedResult> onlysearch, HttpSession session) {
		session.removeAttribute("onlysearch");
		session.setAttribute("onlysearch", onlysearch);
		return null;
	}

	// 논문 검색 결과 전송 폼
	@RequestMapping(value = "searchList_form", method = RequestMethod.GET)
	public String search_form(HttpSession session, Model model) {
		ArrayList<SearchedResult> onlysearch = (ArrayList<SearchedResult>) session.getAttribute("onlysearch");
		model.addAttribute("onlysearch", onlysearch);
		return "search/searchList";
	}

	// 논문 검색 결과 읽기
	@RequestMapping(value = "search_read_only", method = RequestMethod.GET)
	public String searchRead(String issn, Model model, HttpSession session) {
		SearchedResult ss = new SearchedResult();
		System.out.println("전달된 issn" + issn);
		ArrayList<SearchedResult> onlysearch = (ArrayList<SearchedResult>) session.getAttribute("onlysearch");
		System.out.println("전달된 array" + onlysearch);
		for (SearchedResult searchedResult : onlysearch) {
			if (searchedResult.getIssn().equals(issn)) {
				ss.setSearchedAbstract(searchedResult.getSearchedAbstract());
				ss.setSearchedTitle(searchedResult.getSearchedTitle());
				ss.setSearchAbstract(searchedResult.getSearchAbstract());
				ss.setSearchTitle(searchedResult.getSearchTitle());
				ss.setAuthor(searchedResult.getAuthor());
				ss.setSimilarity(searchedResult.getSimilarity());
				ss.setLink(searchedResult.getLink());
				ss.setPublishedDate(searchedResult.getPublishedDate());
				ss.setSearchTitle(searchedResult.getSearchTitle());
				ss.setIssn(searchedResult.getIssn());
				model.addAttribute("onlysearch", ss);
				System.out.println(ss);
				break;
			}
		}
		return "search/searchRead";
	}

	//내부논문 검색하기 
	@ResponseBody
	@RequestMapping(value="searchUniversityThesis", method=RequestMethod.POST)
	public ArrayList<Thesis> searchUniversityThesis(String department, String year, String degree){
		ArrayList<Thesis> result = new ArrayList<Thesis>();
		
		Map<String, Object> keyword = new HashMap<String, Object>();
		
		if (department != null) {
			keyword.put("department", department);
		}
		if (year != null) {
			keyword.put("year", year);
		}
		if (degree != null) {
			keyword.put("degree", degree);
		}
		
		result = service.searchUniversityThesis(keyword);
		
		return result;
	}
	
	@RequestMapping(value="searchThesisDetail", method=RequestMethod.GET)
	public String searchThesisDetail(int thesisSeq, Model model) {
		Thesis result = service.selectThesis(thesisSeq);
		
		model.addAttribute("Thesis", result);
		
		return "/search/searchThesisDetail";
	}
	
	@RequestMapping(value="thesisDownload", method=RequestMethod.GET)
	public void thesisDownload(int thesisSeq, HttpServletResponse response) {
		
		Thesis result = service.selectThesis(thesisSeq);
		
		response.setHeader("Content-Disposition", "attachment;fileName="+result.getThesisOrgname());
		
		FileInputStream fis;
		ServletOutputStream sos;
		
		try {
			fis = new FileInputStream(UPLOADPATH+result.getThesisSavename());
			sos = response.getOutputStream();
			
			FileCopyUtils.copy(fis, sos);
			
			fis.close();
			sos.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
}
