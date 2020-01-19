package global.dclass.team5.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Collections;
import java.util.UUID;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.google.gson.JsonObject;

import global.dclass.team5.VO.Application;
import global.dclass.team5.VO.GroupBoard;
import global.dclass.team5.VO.GroupBoardComments;
import global.dclass.team5.VO.GroupBoardInfo;
import global.dclass.team5.VO.Member;
import global.dclass.team5.VO.Message;
import global.dclass.team5.VO.SearchedResult;
import global.dclass.team5.VO.ThesisTemp;
import global.dclass.team5.service.AdminService;
import global.dclass.team5.service.FileService;
import global.dclass.team5.service.GroupBoardService;
import global.dclass.team5.service.MemberService;
import global.dclass.team5.util.PageNavigator;

@Controller
public class GroupBoardController {

	private static final String uploadPath = "D:/Users/dud54/Desktop/DATA/K-move/36기 D반 5조 프로젝트/Project/ThesisManagementSystem/src/main/webapp/resources/saveFile/";
	// 게시판 관련 상수값들
	private int boardPerPage = 10;
	private int pagePerGroup = 5;

	@Autowired
	GroupBoardService service;
	@Autowired
	MemberService mservice;
	@Autowired
	AdminService aservice;

	// 독립게시판 정보 생성
	@ResponseBody
	@RequestMapping(value = "insertGroupBoardInfo", method = RequestMethod.POST)
	public GroupBoardInfo insertGroupBoardInfo(int applicationSeq, Model model) {
		GroupBoardInfo result = new GroupBoardInfo();

		int groupBoardPw = (int) (Math.random() * 10000);

		result.setGroupBoardNum(applicationSeq);
		result.setGroupBoardId("group" + applicationSeq);
		result.setGroupBoardPw("pw" + groupBoardPw);

		int success = service.insertGroupBoardInfo(result);

		if (success != 1) {
			return null;
		}

		sendConfirmMessage(result);
		updateGroupBoardNum(applicationSeq);

		model.addAttribute("msgCheck", 0);

		return result;
	}

	// 멤버에게 독립게시판 정보 메세지 보내기
	public void sendConfirmMessage(GroupBoardInfo gbInfo) {
		Application application = aservice.selectApplication(gbInfo.getGroupBoardNum());

		Message message0 = new Message();
		Message message1 = new Message();

		message0.setApplicationSeq(application.getApplicationSeq());
		message0.setToId(application.getId());
		message0.setMessageContent("Board IDは [ " + gbInfo.getGroupBoardId() + " ], Board Passwordは [ "
				+ gbInfo.getGroupBoardPw() + " ]です。");

		message1.setApplicationSeq(application.getApplicationSeq());
		message1.setToId(application.getMember1());
		message1.setMessageContent("Board IDは [ " + gbInfo.getGroupBoardId() + " ], Board Passwordは [ "
				+ gbInfo.getGroupBoardPw() + " ]です。");

		mservice.sendConfirmMessage(message0);
		mservice.sendConfirmMessage(message1);

		if (application.getMemberNum() == 3) {
			Message message2 = new Message();

			message2.setApplicationSeq(application.getApplicationSeq());
			message2.setToId(application.getMember2());
			message2.setMessageContent("Board IDは [ " + gbInfo.getGroupBoardId() + " ], Board Passwordは [ "
					+ gbInfo.getGroupBoardPw() + " ]です。");

			mservice.sendConfirmMessage(message2);
		} else if (application.getMemberNum() == 4) {
			Message message2 = new Message();
			Message message3 = new Message();

			message2.setApplicationSeq(application.getApplicationSeq());
			message2.setToId(application.getMember2());
			message2.setMessageContent("Board IDは [ " + gbInfo.getGroupBoardId() + " ], Board Passwordは [ "
					+ gbInfo.getGroupBoardPw() + " ]です。");
			message3.setApplicationSeq(application.getApplicationSeq());
			message3.setToId(application.getMember3());
			message3.setMessageContent("Board IDは [ " + gbInfo.getGroupBoardId() + " ], Board Passwordは [ "
					+ gbInfo.getGroupBoardPw() + " ]です。");

			mservice.sendConfirmMessage(message2);
			mservice.sendConfirmMessage(message3);
		} else {
			Message message2 = new Message();
			Message message3 = new Message();
			Message message4 = new Message();

			message2.setApplicationSeq(application.getApplicationSeq());
			message2.setToId(application.getMember2());
			message2.setMessageContent("Board IDは [ " + gbInfo.getGroupBoardId() + " ], Board Passwordは [ "
					+ gbInfo.getGroupBoardPw() + " ]です。");
			message3.setApplicationSeq(application.getApplicationSeq());
			message3.setToId(application.getMember3());
			message3.setMessageContent("Board IDは [ " + gbInfo.getGroupBoardId() + " ], Board Passwordは [ "
					+ gbInfo.getGroupBoardPw() + " ]です。");
			message4.setApplicationSeq(application.getApplicationSeq());
			message4.setToId(application.getMember4());
			message4.setMessageContent("Board IDは [ " + gbInfo.getGroupBoardId() + " ], Board Passwordは [ "
					+ gbInfo.getGroupBoardPw() + " ]です。");

			mservice.sendConfirmMessage(message2);
			mservice.sendConfirmMessage(message3);
			mservice.sendConfirmMessage(message4);
		}
	}

	// 회원정보에 독립게시판 번호 업데이트
	public void updateGroupBoardNum(int applicationSeq) {
		Application application = aservice.selectApplication(applicationSeq);

		mservice.updateGroupBoardNum(application);
	}

	// 독립게시판 로그인 페이지로 가기
	@RequestMapping(value = "goGroupBoardLogin", method = RequestMethod.GET)
	public String goGroupBoardLogin() {
		return "/groupboard/goGroupBoardLogin";
	}

	// 독립게시판 아이디 체크
	@ResponseBody
	@RequestMapping(value = "checkBoardId", method = RequestMethod.GET)
	public GroupBoardInfo checkBoardId(String groupBoardId) {
		GroupBoardInfo result = service.selectGroupBoardInfo(groupBoardId);

		if (result == null) {
			return null;
		}

		return result;
	}

	// 독립게시판으로 가기
	@RequestMapping(value = "goGroupBoard", method = RequestMethod.GET)
	public String goGroupBoard(HttpSession session) {

		int groupBoardNum = (Integer) session.getAttribute("groupBoardNum");

		if (groupBoardNum == 0) {
			return "redirect:/goGroupBoardLogin";
		}
		return "/groupboard/goGroupBoard";
	}

	// 독립게시판 로그인
	@RequestMapping(value = "loginGroupBoard", method = RequestMethod.POST)
	public String loginGroupBoard(String groupBoardId, HttpSession session) {

		GroupBoardInfo result = service.selectGroupBoardInfo(groupBoardId);

		session.setAttribute("groupBoardNum", result.getGroupBoardNum());

		return "/groupboard/goGroupBoard";
	}

	// 게시판 글쓰기
	@RequestMapping(value = "groupBoard_write", method = RequestMethod.GET)
	public String wirteForm() {
		return "groupboard/groupBoard_writeForm";
	}

	// 글 저장
	@RequestMapping(value = "groupBoard_write", method = RequestMethod.POST)
	public String insert_write(GroupBoard board, HttpSession session, MultipartFile upload, Model model) {
		String id = (String) session.getAttribute("loginId");
		int num = (Integer) session.getAttribute("groupBoardNum");
		board.setGroupBoardNum(num);
		board.setGroupBoardId(id);
		System.out.println(board);
		if (!upload.isEmpty()) {
			String savedfile = FileService.saveFile(upload, uploadPath);
			board.setOrgname(upload.getOriginalFilename());
			board.setSavename(savedfile);
		}
		System.out.println(board);
		service.insertBoard(board);
		return "redirect:groupboard_list";
	}

	// 조회수 올리기
	@RequestMapping(value = "groupBoard_hit", method = RequestMethod.POST)
	public String addHits(int groupBoardSeq, HttpSession session) {
		GroupBoard board = new GroupBoard();
		int num = (Integer) session.getAttribute("groupBoardNum");
		board.setGroupBoardNum(num);
		board.setGroupBoardSeq(groupBoardSeq);
		service.addHits(board);

		return null;
	}

	// 글목록
	@RequestMapping(value = "groupboard_list", method = RequestMethod.GET)
	public String list(@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "keyField", defaultValue = "") String keyField,
			@RequestParam(value = "keyWord", defaultValue = "") String keyWord, Model model, HttpSession session) {
		String groupBoardNum = String.valueOf(session.getAttribute("groupBoardNum"));
		int totalCount = service.getTotal(groupBoardNum, keyField, keyWord);

		PageNavigator navi = new PageNavigator(boardPerPage, pagePerGroup, page, totalCount);

		ArrayList<GroupBoard> boardlist = service.listBoard(navi, groupBoardNum, keyField, keyWord);
		model.addAttribute("boardlist", boardlist);
		model.addAttribute("navi", navi);
		return "/groupboard/groupBoard_list";
	}

	// 글읽기
	@RequestMapping(value = "groupBoard_read", method = RequestMethod.GET)
	public String read(int groupBoardSeq, Model model, HttpSession session) {
		int num = (Integer) session.getAttribute("groupBoardNum");
		GroupBoard board = new GroupBoard();
		board.setGroupBoardNum(num);
		board.setGroupBoardSeq(groupBoardSeq);
		GroupBoard iboard = service.getBoard(board);
		model.addAttribute("board", iboard);
		return "/groupboard/groupBoard_read";
	}

	// 글삭제
	@RequestMapping(value = "groupBoard_delete", method = RequestMethod.GET)
	public String delete(int groupBoardSeq, HttpSession session) {
		GroupBoard board = new GroupBoard();
		int num = (Integer) session.getAttribute("groupBoardNum");
		board.setGroupBoardNum(num);
		board.setGroupBoardSeq(groupBoardSeq);
		System.out.println(board);
		service.deleteBoard(board);

		return "redirect:groupboard_list";
	}

	// 다운로드
	@RequestMapping(value = "groupBoard_download", method = RequestMethod.GET)
	public String fileDownload(int groupBoardSeq, Model model, HttpServletResponse response, HttpSession session) {
		int num = (Integer) session.getAttribute("groupBoardNum");
		GroupBoard board = new GroupBoard();
		board.setGroupBoardNum(num);
		board.setGroupBoardSeq(groupBoardSeq);
		GroupBoard nboard = service.getBoard(board);

		String orgname = new String(nboard.getOrgname());
		try {
			response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(orgname, "UTF-8"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		String fullPath = uploadPath + "/" + nboard.getSavename();
		FileInputStream filein = null;
		ServletOutputStream fileout = null;
		try {
			filein = new FileInputStream(fullPath);
			fileout = response.getOutputStream();
			FileCopyUtils.copy(filein, fileout);
			filein.close();
			fileout.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

	// 글수정
	@RequestMapping(value = "groupBoard_edit", method = RequestMethod.GET)
	public String editForm(int groupBoardSeq, HttpSession session, Model model) {
		GroupBoard board1 = new GroupBoard();
		int num = (Integer) session.getAttribute("groupBoardNum");
		board1.setGroupBoardNum(num);
		board1.setGroupBoardSeq(groupBoardSeq);
		GroupBoard board = service.getBoard(board1);
		model.addAttribute("board", board);
		System.out.println(board);
		return "/groupboard/groupBoard_editForm";
	}

	// 글수정
	@RequestMapping(value = "groupBoard_edit", method = RequestMethod.POST)
	public String edit(GroupBoard board, MultipartFile upload, HttpSession session) {

		String id = (String) session.getAttribute("loginId");
		int num = (Integer) session.getAttribute("groupBoardNum");
		board.setGroupBoardNum(num);
		board.setGroupBoardId(id);
		GroupBoard oldBoard = service.getBoard(board);
		if (oldBoard == null || !oldBoard.getGroupBoardId().equals(id)) {
			return "redirect:groupboard_list";
		}
		if (!upload.isEmpty()) {
			String savedfile = oldBoard.getSavename();
			if (savedfile != null) {
				FileService.deleteFile(uploadPath + "/" + savedfile);
			}
			savedfile = FileService.saveFile(upload, uploadPath);
			board.setOrgname(upload.getOriginalFilename());
			board.setSavename(savedfile);
		}
		service.updateBoard(board);
		return "redirect:groupBoard_read?groupBoardSeq=" + board.getGroupBoardSeq();
	}

	// 게시판 파일 삭제
	@ResponseBody
	@RequestMapping(value = "groupFileDelete", method = RequestMethod.POST)
	public int groupFileDelete(GroupBoard board) {
		int result = 0;

		GroupBoard groupBoard = service.getBoard(board);

		File deleteFile = new File(uploadPath + groupBoard.getSavename());
		if (deleteFile.isFile()) {
			deleteFile.delete();
		}

		result = service.groupFileDelete(board);

		return result;
	}

	// 리플 저장
	@RequestMapping(value = "groupBoard_replyWrite", method = RequestMethod.POST)
	@ResponseBody
	public String replyWrite(GroupBoardComments reply, HttpSession session) {
		String id = (String) session.getAttribute("loginId");
		int num = (Integer) session.getAttribute("groupBoardNum");
		reply.setGroupBoardNum(num);
		reply.setGbcid(id);
		System.out.println("입력" + reply);
		service.insertReply(reply);
		return null;
	}

	// 리플 리스트
	@RequestMapping(value = "/groupBoard_replylist", method = RequestMethod.GET)
	@ResponseBody
	public ArrayList<GroupBoardComments> replylist(int groupBoardSeq, HttpSession session) {
		GroupBoardComments reply = new GroupBoardComments();
		int num = (Integer) session.getAttribute("groupBoardNum");
		reply.setGroupBoardNum(num);
		reply.setGroupBoardSeq(groupBoardSeq);
		ArrayList<GroupBoardComments> nReplylist = service.listReply(reply);
		return nReplylist;
	}

	// 리플수정
	@RequestMapping(value = "groupBoard_replyUpdate", method = RequestMethod.POST)
	@ResponseBody
	public String updateReply(GroupBoardComments reply, HttpSession session) {
		int num = (Integer) session.getAttribute("groupBoardNum");
		String id = (String) session.getAttribute("loginId");
		reply.setGroupBoardNum(num);
		reply.setGbcid(id);
		System.out.println("controller 수정" + reply);
		service.updateReply(reply);
		return null;
	}

	// 리플 삭제
	@RequestMapping(value = "groupBoard_replyDelete", method = RequestMethod.POST)
	@ResponseBody
	public String deleteReply(GroupBoardComments reply, HttpSession session) {
		String id = (String) session.getAttribute("loginId");
		int num = (Integer) session.getAttribute("groupBoardNum");
		reply.setGroupBoardNum(num);
		reply.setGbcid(id);
		System.out.println("삭제\n" + reply);
		service.deleteReply(reply);
		return null;
	}

	// 일정들어가기
	@RequestMapping(value = "goGroupBoardCalendar", method = RequestMethod.GET)
	public String goGroupBoardCalendar() {
		return "/groupboard/goGroupBoard_calendar";
	}

	// 이미지 첨부 컨트롤러
	@RequestMapping(value = "/fileUpload", method = RequestMethod.POST)
	@ResponseBody
	public String fileUpload(HttpServletRequest request, HttpServletResponse response,
			MultipartHttpServletRequest multiFile) throws Exception {
		// Multipart 요청이 들어올 때 내부적으로 원본 HttpServletRequest 대신 사용되는 인터페이스.
		JsonObject json = new JsonObject();
		PrintWriter printWriter = null;
		OutputStream out = null;
		MultipartFile file = multiFile.getFile("upload");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");

		if (file != null) {
			if (file.getSize() > 0 && StringUtils.isNotBlank(file.getName())) {
				if (file.getContentType().toLowerCase().startsWith("image/")) {
					try {
						String fileName = file.getName();
						byte[] bytes = file.getBytes();
						String uploadPath = request.getSession().getServletContext().getRealPath("/img");
						System.out.println(uploadPath);

						File uploadFile = new File(uploadPath);
						if (!uploadFile.exists()) { // uploadFile이 존재하지 않으면,

							uploadFile.mkdirs();// 새로 디렉토리를 생성한다.
						}

						fileName = UUID.randomUUID().toString();// 저장하려는 파일이름을 랜덤으로 생성해준다.
						uploadPath = uploadPath + "/" + fileName;
						out = new FileOutputStream(new File(uploadPath));
						out.write(bytes);

						printWriter = response.getWriter();
						response.setContentType("text/html");
						String fileUrl = request.getContextPath() + "/img/" + fileName;

						// json 데이터로 등록
						// {"uploaded" : 1, "fileName" : "test.jpg", "url" : "/img/test.jpg"}
						// 이런 형태로 리턴이 나가야함.
						json.addProperty("uploaded", 1);
						json.addProperty("fileName", fileName);
						json.addProperty("url", fileUrl);

						printWriter.println(json);

					} catch (IOException e) {
						e.printStackTrace();
					} finally {
						if (out != null) {
							out.close();
						}
						if (printWriter != null) {
							printWriter.close();
						}
					}
				}
			}
		}
		return null;
	}

	// 논문 유사도 검사
	@ResponseBody
	@RequestMapping(value = "similarity", method = RequestMethod.POST)
	public String similarity(@RequestBody ArrayList<SearchedResult> templist, HttpSession session) {
		System.out.println("제일 처음 받는부분" + templist);
		session.setAttribute("resultList", templist);
		return null;
	}

	// 유사도 결과 전송 폼
	@RequestMapping(value = "similarity_form", method = RequestMethod.GET)
	public String similarity(HttpSession session, Model model) {
		double result = 0;
		ArrayList<SearchedResult> resultList = (ArrayList<SearchedResult>) session.getAttribute("resultList");
		for (SearchedResult searchedResult : resultList) {
			result = searchedResult.getSimilarity();
			if (result <= 1) {
				if (result <= 0.50) {
					result = result * 100;
					result = (result / 50) * 10;
					searchedResult.setSimilarity(result);
				} else if (result > 0.50 && result <= 0.80) {
					result = result * 100;
					result = (((result - 50) / 30) * 60) + 10;
					searchedResult.setSimilarity(result);
				} else {
					result = result * 100;
					result = (((result - 80) / 20) * 30) + 70;
					searchedResult.setSimilarity(result);
				}
			}

		}
		SearchedResult sr = new SearchedResult();
		Collections.sort(resultList, sr);
		model.addAttribute("resultList", resultList);
		return "groupboard/similarity_form";
	}

	// 유사도 상세정보 확인 폼
	@RequestMapping(value = "similarity_read", method = RequestMethod.GET)
	public String similarity_read(String issn, Model model, HttpSession session) {
		double result = 0;
		SearchedResult ss = new SearchedResult();
		System.out.println("전달된 issn" + issn);
		ArrayList<SearchedResult> resultList = (ArrayList<SearchedResult>) session.getAttribute("resultList");
		System.out.println("전달된 array" + resultList);
		for (SearchedResult searchedResult : resultList) {
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
				model.addAttribute("result", ss);
				System.out.println(ss);
				break;
			}
		}
		return "groupboard/similarity_read";
	}

	// 맞춤법 검사
	@RequestMapping(value = "/wordCheck", method = RequestMethod.GET)
	public String wordCheck() {
		return "groupboard/wordCheck";
	}

	// 논문 임시 저장
	@ResponseBody
	@RequestMapping(value = "/insertThesisTemp", method = RequestMethod.POST)
	public int insertThesisTemp(ThesisTemp temp, HttpSession session) {
		String teamName = "";
		int num = (Integer) session.getAttribute("groupBoardNum");
		ArrayList<Member> teamMember = mservice.selectTeamMember(num);
		for (int i = 0; i < teamMember.size(); i++) {
			String name = teamMember.get(i).getName();
			teamName += name;
			if (teamMember.size() != i + 1) {
				teamName += ", ";
			}
		}
		System.out.println(teamName);
		temp.setTeamName(teamName);
		temp.setGroupBoardNum(num);
		int result = service.insertThesisTemp(temp);

		return result;
	}
	// 임시 저장한 논문 불러오기>>논문 페이지 띄우가

	@RequestMapping(value = "/thesisWrite", method = RequestMethod.GET)
	public String selectThesisTemp(Model model, HttpSession session) {
		int num = (Integer) session.getAttribute("groupBoardNum");
		ThesisTemp temp = service.selectThesisTemp(num);
		if (temp != null) {
			model.addAttribute("thesisTitle", temp.getThesisTitle());
			model.addAttribute("thesisAbstract", temp.getThesisAbstract());
			model.addAttribute("editor", temp.getEditor());
			model.addAttribute("seq_thesistemp", temp.getSeq_thesistemp());
		}

		return "groupboard/thesisWriteForm";
	}

}
