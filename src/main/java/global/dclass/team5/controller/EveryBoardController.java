package global.dclass.team5.controller;

import java.io.File;
import java.io.FileInputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import global.dclass.team5.VO.EveryBoard;
import global.dclass.team5.VO.EveryBoardComments;
import global.dclass.team5.service.EveryBoardService;
import global.dclass.team5.util.PageNavigator;

@Controller
public class EveryBoardController {
	
	@Autowired
	EveryBoardService service;
	
	private static final String UPLOADPATH = "D:/Users/dud54/Desktop/DATA/K-move/36기 D반 5조 프로젝트/Project/ThesisManagementSystem/src/main/webapp/resources/saveFile/";
	private int boardPerPage = 10;
	private int pagePerGroup = 5;
	
	//전체게시판 가기
	@RequestMapping(value="goEveryBoard", method=RequestMethod.GET)
	public String goEveryBoardForm() {
		return "/everyboard/goEveryBoard";
	}
	
	//전체게시판 불러오기
	@RequestMapping(value="everyBoard", method=RequestMethod.GET)
	public String selectAllEveryBoard(@RequestParam(value="page", defaultValue="1") int page, Model model, @RequestParam(value="keyField", defaultValue="") String keyField, @RequestParam(value="keyWord", defaultValue="") String keyWord){
		
		int totalCount = service.totalCount(keyField, keyWord);

		PageNavigator pn = new PageNavigator(boardPerPage, pagePerGroup, page, totalCount);
		
		ArrayList<EveryBoard> result = new ArrayList<EveryBoard>();
	
		result = service.selectAllEveryBoard(pn, keyField, keyWord);

		model.addAttribute("navi", pn);
		model.addAttribute("EveryBoard", result);
		
		return "/everyboard/everyBoard";
	}
	
	//게시판 하나 들고오기
	@ResponseBody
	@RequestMapping(value="getBoard", method=RequestMethod.POST)
	public EveryBoard getBoard(int everyBoardSeq) {
		EveryBoard result = null;
		
		result = service.getBoard(everyBoardSeq);
		
		return result;
	}
	
	//게시글 보기
	@RequestMapping(value="everyBoardDetail", method=RequestMethod.GET)
	public String everyBoardDetail(int everyBoardSeq, Model model) {
		
		EveryBoard result = service.selectEveryBoard(everyBoardSeq);
		
		model.addAttribute("EveryBoard", result);
		
		return "/everyboard/everyBoardDetail";
	}
	
	//조회수 업데이트
	@ResponseBody
	@RequestMapping(value="updateHitcount", method=RequestMethod.POST)
	public void updateHitcount(int everyBoardSeq) {
		service.updateHitcount(everyBoardSeq);
	}
	
	//전체게시판 글쓰기 페이지 이동
	@RequestMapping(value="everyBoardWrite", method=RequestMethod.GET)
	public String goEveryBoardWrite() {
		return "/everyboard/everyBoardWrite";
	}
	
	//게시판 글쓰기
	@RequestMapping(value="insertEveryBoard", method=RequestMethod.POST)
	public String insertEveryBoard(EveryBoard board, HttpSession session, MultipartFile upload) {
		
		String id = (String) session.getAttribute("loginId");
		board.setId(id);
		
		if (!upload.isEmpty()) {
			String orgName = upload.getOriginalFilename();
			
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			double name = (Math.random())*10000000;
			
			String timeName = sdf.format(date)+name;
			
			String extension = orgName.split("\\.")[orgName.split("\\.").length-1];
			System.out.println(extension);
			String saveName = timeName+"."+extension;
			
			try {
				upload.transferTo(new File(UPLOADPATH+saveName));
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			board.setEveryBoardOrgname(orgName);
			board.setEveryBoardSavename(saveName);
		} else {
			board.setEveryBoardOrgname("");
			board.setEveryBoardSavename("");
		}
		int success = service.insertEveryBoard(board);
		
		if (success != 1) {
			return "redirect:/everyBoardWrite";
		}
		
		return "redirect:/everyBoard";
	}
	
	//파일 다운로드
	@RequestMapping(value="everyBoardDownload", method=RequestMethod.GET)
	public void download(HttpServletResponse response, int everyBoardSeq) {
		
		EveryBoard board = service.getBoard(everyBoardSeq);
		
		response.setHeader("Content-Disposition", "attachment;fileName="+board.getEveryBoardOrgname());
		
		FileInputStream fis;
		ServletOutputStream sos;
		
		try {
			fis = new FileInputStream(UPLOADPATH+board.getEveryBoardSavename());
			sos = response.getOutputStream();
			
			FileCopyUtils.copy(fis, sos);
			
			fis.close();
			sos.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	//글쓰기 업데이트
	@RequestMapping(value="updateEveryBoard", method=RequestMethod.GET)
	public String goUpdateEveryBoard(int everyBoardSeq, Model model) {
		EveryBoard result = service.selectEveryBoard(everyBoardSeq);
		if (result == null) {
			return "redirect:/everyBoard";
		}
		
		model.addAttribute("EveryBoard", result);
		
		return "/everyboard/updateEveryBoardWrite";
	}
	
	//게시판 업데이트
	@RequestMapping(value="updateEveryBoard", method=RequestMethod.POST)
	public String updateEveryBoard(EveryBoard board, MultipartFile upload, Model model) {
		
		if (!upload.isEmpty()) {
			String orgName = upload.getOriginalFilename();
			
			System.out.println(orgName);
			
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			double name = (Math.random())*10000000;
			
			String timeName = sdf.format(date)+name;
			
			String extension = orgName.split("\\.")[orgName.split("\\.").length-1];
			
			String saveName = timeName+"."+extension;
			
			try {
				upload.transferTo(new File(UPLOADPATH+saveName));
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			board.setEveryBoardOrgname(orgName);
			board.setEveryBoardSavename(saveName);

		} else {
			board.setEveryBoardOrgname("");
			board.setEveryBoardSavename("");
		}
		
		int success = service.updateEveryBoard(board);
		
		if (success != 1) {
			return "redirect:/updateEveryBoardWrite";
		}
		
		EveryBoard result = service.selectEveryBoard(board.getEveryBoardSeq());
		
		model.addAttribute("EveryBoard", result);
		
		return "/everyboard/everyBoardDetail";
	}
	
	//게시판 첨부파일 삭제
	@ResponseBody
	@RequestMapping(value="fileDelete", method=RequestMethod.POST)
	public int fileDelete(int everyBoardSeq) {
		int result = 0;
		
		EveryBoard everyBoard = service.getBoard(everyBoardSeq);
		
		 File deleteFile = new File(UPLOADPATH+everyBoard.getEveryBoardSavename());
		 if (deleteFile.isFile()) {
				deleteFile.delete();
		 }
		 
		result = service.fileDelete(everyBoardSeq);
		
		return result;
	}
	
	//게시판 삭제
	@RequestMapping(value="deleteEveryBoard", method=RequestMethod.GET)
	public String deleteEveryBoard(int everyBoardSeq) {
		
		int result = service.deleteEveryBoard(everyBoardSeq);
		
		if (result != 1) {
			return "redirect:/everyBoard";
		}
		
		return "redirect:/everyBoard";
	}
	
	//전체 달력 이동
	@RequestMapping(value="everyBoardCalendar", method=RequestMethod.GET)
	public String everyBoardCalendar () {
		return "/everyboard/everyBoardCalendar";
	}
	

	//댓글 전체출력
	@ResponseBody
	@RequestMapping(value="all_comment", method=RequestMethod.POST)
	public ArrayList<EveryBoardComments> selectAllComment(int everyBoardSeq){
	
		ArrayList<EveryBoardComments> comment_result =service.selectAllComment(everyBoardSeq);		
		

		return comment_result;
	}
	
	
	//댓글 입력
	@ResponseBody
	@RequestMapping(value="insert_comment", method=RequestMethod.POST)
	public int insertComment(EveryBoardComments everyBoardComments,HttpSession session) {		
		
		int result = 0;

		try {			
			everyBoardComments.setId((String) session.getAttribute("loginId"));
			result = service.insert_comments(everyBoardComments);			
		}catch(Exception e) {			
				e.printStackTrace();
			}
		
		return result;		
	}

	//comment 수정
	@ResponseBody
	@RequestMapping(value="update_comment", method=RequestMethod.POST)
	public int updateComment(EveryBoardComments everyBoardComments,HttpSession session) {		
		everyBoardComments.setId((String) session.getAttribute("loginId"));
	
		System.out.println(everyBoardComments);
		int result = service.update_comments(everyBoardComments);				
		
		return result;		
	}
	
	//댓글 삭제
	@ResponseBody
	@RequestMapping(value="delete_comment", method=RequestMethod.POST)
	public int deleteComment(EveryBoardComments everyBoardComments,HttpSession session) {		
		everyBoardComments.setId((String) session.getAttribute("loginId"));		
		System.out.println(everyBoardComments);
		int result = service.delete_comments(everyBoardComments);			
		
		return result;		
	}

}
