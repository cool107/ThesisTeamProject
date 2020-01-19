package global.dclass.team5.DAO;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import global.dclass.team5.VO.GroupBoard;
import global.dclass.team5.VO.GroupBoardComments;
import global.dclass.team5.VO.GroupBoardInfo;
import global.dclass.team5.VO.ThesisTemp;

public interface GroupBoardMapper {

	//그룹정보 생성
	public int insertGroupBoardInfo(GroupBoardInfo result);

	//그룹아이디 체크
	public GroupBoardInfo selectGroupBoardInfo(String groupBoardId);

	//게시판 입력
	public int insertBoard(GroupBoard board);
	
	//게시판 개별 조회
	public GroupBoard getBoard(GroupBoard board);
	
	//조회수 증가
	public int addHits(GroupBoard board);
	
	//전체 게시판 조회
	public ArrayList<GroupBoard> listBoard(RowBounds rb, Map<String, String> map);
	
	//게시판 삭제
	public int deleteBoard(GroupBoard board);
	
	//게시판 수정
	public int updateBoard(GroupBoard board);
	
	//리플 입력
	public int insertReply(GroupBoardComments reply);
	
	//전체 리플 목록 조회
	public ArrayList<GroupBoardComments> listReply(GroupBoardComments gReply);
	
	//리플 개별 선택
	public GroupBoardComments selectReply(GroupBoardComments reply);
	
	//리플 삭제
	public int deleteReply(GroupBoardComments reply);
	
	//리플 수정
	public int updateReply(GroupBoardComments reply);
	
	//전체 글수
	public int getTotal(Map<String, String> map);

	//첨부파일 삭제
	public int groupFileDelete(GroupBoard board);
	
	//논문 임시 저장
	public int insertThesisTemp(ThesisTemp temp);
	
	//임시 저장 논문 불러오기
	public ThesisTemp selectThesisTemp(int groupBoardNum);

	
	
	
	
	
}
