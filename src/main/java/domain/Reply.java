package domain;

public class Reply {
	
	private int id, idx, ref, depth, step;
	
	private Board board;
	
	public Board getBoard() {
		return board;
	}

	public void setBoard(Board board) {
		this.board = board;
	}

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	private String writer, content, write_date , type;


	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getRef() {
		return ref;
	}

	public void setRef(int ref) {
		this.ref = ref;
	}

	public int getDepth() {
		return depth;
	}

	public void setDepth(int depth) {
		this.depth = depth;
	}

	public int getStep() {
		return step;
	}

	public void setStep(int step) {
		this.step = step;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getWrite_date() {
		return write_date;
	}

	public void setWrite_date(String write_date) {
		this.write_date = write_date;
	}

	@Override
	public String toString() {
		return "Reply [id=" + id + ", idx=" + idx + ", ref=" + ref + ", depth=" + depth + ", step=" + step + ", writer="
				+ writer + ", content=" + content + ", write_date=" + write_date + ", type=" + type + ", getIdx()="
				+ getIdx() + ", getType()=" + getType() + ", getId()=" + getId() + ", getRef()=" + getRef()
				+ ", getDepth()=" + getDepth() + ", getStep()=" + getStep() + ", getWriter()=" + getWriter()
				+ ", getContent()=" + getContent() + ", getWrite_date()=" + getWrite_date() + ", getClass()="
				+ getClass() + ", hashCode()=" + hashCode() + ", toString()=" + super.toString() + "]";
	}


}
