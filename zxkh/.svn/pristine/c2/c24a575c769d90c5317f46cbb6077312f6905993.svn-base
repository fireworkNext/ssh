package org.ptbank.action;

import java.io.FileInputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;

import org.apache.struts2.ServletActionContext;
import org.ptbank.func.Configuration;

public class DownloadAction extends BaseAction {

	private static final long serialVersionUID = 1656950476675155655L;
	private String md5;
	private String filename;
	private String directory;

	@Override
	public String execute() throws Exception {
		return SUCCESS;
	}

	public InputStream getInputStream() throws Exception {
		String conf=ServletActionContext.getServletContext().getRealPath("/WEB-INF/classes/conf.properties");
		Configuration rc = new Configuration(conf);
	    String realpath=rc.getValue("filepath");
		String dir = realpath + filename;
		return new FileInputStream(dir); // 如果dir是绝对路径
		// return ServletActionContext.getServletContext().getResourceAsStream(dir); //如果dir是Resource下的相对路径
	}

	/**
	 * @return the md5
	 */
	public String getMd5() {
		return md5;
	}

	/**
	 * @param md5
	 *            the md5 to set
	 */
	public void setMd5(String md5) {
		this.md5 = md5;
	}

	/**
	 * @return the filename
	 */
	public String getFilename() {
		return filename;
	}

	/**
	 * @param filename
	 *            the filename to set
	 */
	public void setFilename(String filename) {
		try {
			this.filename = new String(filename.getBytes("ISO-8859-1"), "GBK");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}

	/**
	 * @param directory
	 *            the directory to set
	 */
	public void setDirectory(String directory) {
		this.directory = directory;
	}
}
