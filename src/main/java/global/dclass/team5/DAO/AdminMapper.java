package global.dclass.team5.DAO;

import java.util.ArrayList;

import global.dclass.team5.VO.Application;
import global.dclass.team5.VO.Thesis;
import global.dclass.team5.VO.ThesisForm;
import global.dclass.team5.VO.ThesisTemp;

public interface AdminMapper {

	//select all application
	public ArrayList<Application> searchApplication();
	
	//insert group board
	public int insertGroupBoard();

	//select one application
	public Application selectApplication(int applicationSeq);
	
	//update admincheck 
	public int updateAdminCheck(int applicationSeq);

	//update membercheck
	public int updateMemberCheck(int applicationSeq);

	//select ThesisForm
	public ThesisForm selectThesisForm(String department);

	//update ThesisForm
	public int updateThesisForm(ThesisForm form);
	
	//submit final Thesis
	public int finalFileUpload(ThesisTemp temp);

	//select Thesis Temp
	public ArrayList<ThesisTemp> selectThesisTemp();

	//select one Thesis Temp
	public ThesisTemp oneThesisTemp(int seq_thesistemp);

	//insert Thesis
	public int insertThesisSubmit(ThesisTemp result);

	//update Thesis Temp ThesisComplete
	public void updateThesisSubmit(int seq_thesistemp);

}
