import React from "react"
class Category extends React.Component {

  constructor(props){
    super(props);
    this.state={isListOpen: false}
  };

  handleOverOpen(){
    this.setState({isListOpen: true});
  }

  handleClickClose(){
    this.setState({isListOpen: false});
  }


  render () {
    let list;
    if (this.state.isListOpen){
      list = (
        <div>
          <a href=" /categorys/2"><p class="category-btn">{this.props.name1}</p></a>
          <a href=" /categorys/3"><p class="category-btn">{this.props.name2}</p></a>
          <a href=" /categorys/4"><p class="category-btn">{this.props.name3}</p></a>
          <a href=" /categorys/5"><p class="category-btn">{this.props.name4}</p></a>
          <a href=" /categorys/6"><p class="category-btn">{this.props.name5}</p></a>
          <a href=" /categorys/7"><p class="category-btn">{this.props.name6}</p></a>
          <a href=" /categorys/8"><p class="category-btn">{this.props.name7}</p></a>
          <button onClick={() => {this.handleClickClose()}}>
            閉じる
          </button>
        </div>
      );
    }
    return (
      <React.Fragment>
        <div className="category-list"
          onMouseOver={() => {this.handleOverOpen()}}
        >
          カテゴリー
        </div>
        {list}
      </React.Fragment>
    );
  }
}

export default Category;
