package global.dclass.team5.DAO;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.ResponseBody;

import global.dclass.team5.VO.Progress;
import global.dclass.team5.controller.ProgressController;

@Repository
public class ProgressDAO {

	@Autowired
	SqlSession session;
	
	public ArrayList<Progress> select_group_progress(int groupBoardNum){
		ProgressMapper mapper = session.getMapper(ProgressMapper.class);			
		return mapper.select_group_progress(groupBoardNum);

	}

	public Progress select_all_day_avg_progress(Progress progress){
		ProgressMapper mapper = session.getMapper(ProgressMapper.class);				
		return mapper.select_all_day_avg_progress(progress);
		
	}
	
	public ArrayList<Progress> select_7_day_avg_progress(int groupBoardNum){
		ProgressMapper mapper = session.getMapper(ProgressMapper.class);		
		return mapper.select_7_day_avg_progress(groupBoardNum);
	}
	
	public int all_select_7_day_avg_progress(int groupBoardNum) {
		ProgressMapper mapper = session.getMapper(ProgressMapper.class);		
		return mapper.all_select_7_day_avg_progress(groupBoardNum);
		
	}
	
	public  ArrayList<Progress> progress_log(int groupBoardNum) {
		ProgressMapper mapper = session.getMapper(ProgressMapper.class);		
		return mapper.progress_log(groupBoardNum);
		
	}
	public int insert_progress(Progress progress) {

		ProgressMapper mapper = session.getMapper(ProgressMapper.class);
		return mapper.insert_progress(progress);
	}
	
	public int delete_progress(int progressNum) {
		ProgressMapper mapper = session.getMapper(ProgressMapper.class);
		return mapper.delete_progress(progressNum);	
	}
	
}
