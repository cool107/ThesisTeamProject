package global.dclass.team5.VO;

import java.util.Comparator;

public class SearchedResult implements Comparator<SearchedResult>{
	private String searchTitle;
	private String searchedTitle;
	private String searchAbstract;
	private String searchedAbstract;
	private String issn;
	private String author;
	private double similarity;
	private String publishedDate;
	private String link;

	public SearchedResult() {
		super();
		// TODO Auto-generated constructor stub
	}

	public SearchedResult(String searchTitle, String searchedTitle, String searchAbstract, String searchedAbstract,
			String issn, String author, double similarity, String publishedDate, String link) {
		super();
		this.searchTitle = searchTitle;
		this.searchedTitle = searchedTitle;
		this.searchAbstract = searchAbstract;
		this.searchedAbstract = searchedAbstract;
		this.issn = issn;
		this.author = author;
		this.similarity = similarity;
		this.publishedDate = publishedDate;
		this.link = link;
	}

	public String getSearchTitle() {
		return searchTitle;
	}

	public void setSearchTitle(String searchTitle) {
		this.searchTitle = searchTitle;
	}

	public String getSearchedTitle() {
		return searchedTitle;
	}

	public void setSearchedTitle(String searchedTitle) {
		this.searchedTitle = searchedTitle;
	}

	public String getSearchAbstract() {
		return searchAbstract;
	}

	public void setSearchAbstract(String searchAbstract) {
		this.searchAbstract = searchAbstract;
	}

	public String getSearchedAbstract() {
		return searchedAbstract;
	}

	public void setSearchedAbstract(String searchedAbstract) {
		this.searchedAbstract = searchedAbstract;
	}

	public String getIssn() {
		return issn;
	}

	public void setIssn(String issn) {
		this.issn = issn;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public double getSimilarity() {
		return similarity;
	}

	public void setSimilarity(double similarity) {
		this.similarity = similarity;
	}

	public String getPublishedDate() {
		return publishedDate;
	}

	public void setPublishedDate(String publishedDate) {
		this.publishedDate = publishedDate;
	}

	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
	}

	@Override
	public String toString() {
		return "SearchedResult [searchTitle=" + searchTitle + ", searchedTitle=" + searchedTitle + ", searchAbstract="
				+ searchAbstract + ", searchedAbstract=" + searchedAbstract + ", issn=" + issn + ", author=" + author
				+ ", similarity=" + similarity + ", publishedDate=" + publishedDate + ", link=" + link + "]";
	}

	@Override
	public int compare(SearchedResult arg0, SearchedResult arg1) {
		double first = arg0.getSimilarity();
		double second=arg1.getSimilarity();
		// TODO Auto-generated method stub
		if(first>second) {
			return -1;
		}else if(first<second) {
			return 1;
		}else {
			return 0;
		}
	}

}
