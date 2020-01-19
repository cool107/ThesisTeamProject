package global.dclass.team5.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import global.dclass.team5.DAO.ProgressDAO;
import global.dclass.team5.VO.Progress;

@Service
public class ProgressService {
	@Autowired
		ProgressDAO Pdao;

	public ArrayList<Progress> select_group_progress(int groupBoardNum) {		
		return Pdao.select_group_progress(groupBoardNum);
	}

	public Progress select_all_day_avg_progress(Progress progress) {		
		return Pdao.select_all_day_avg_progress(progress);
	
	}
	
	public ArrayList<Progress> select_7_day_avg_progress(int groupBoardNum){		
		return Pdao.select_7_day_avg_progress(groupBoardNum);
	}
	
	public int all_select_7_day_avg_progress(int groupBoardNum) {
		return Pdao.all_select_7_day_avg_progress(groupBoardNum);
	}
	
	public  ArrayList<Progress> progress_log(int groupBoardNum) {		
		return Pdao.progress_log(groupBoardNum);
		
	}
	
	public int insert_progress(Progress progress) {		
		return Pdao.insert_progress(progress);
	}
	
	public int delete_progress(int progressNum) {
		
		System.out.println(Pdao.delete_progress(progressNum));
		return Pdao.delete_progress(progressNum);
	}
}
