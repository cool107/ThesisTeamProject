package global.dclass.team5.DAO;

import java.util.ArrayList;

import global.dclass.team5.VO.Progress;

public interface ProgressMapper {
	
	//팀별 전체
	public ArrayList<Progress> select_group_progress(int groupBoardNum);
	
	//전체 평균
	public Progress select_all_day_avg_progress(Progress progress);
	
	//일주일 멤버 + 전체평균
	public int all_select_7_day_avg_progress(int groupBoardNum);
	
	//인서트 된 기록
	public  ArrayList<Progress> progress_log(int groupBoardNum);
	
	//일주일 간 멤버별 평균 진행률
	public ArrayList<Progress> select_7_day_avg_progress(int groupBoardNum);
	
	public int insert_progress(Progress progress);
	
	public int delete_progress(int progressNum);
		
}
