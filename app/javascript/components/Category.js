import React from "react"
class Category extends React.Component {
  
  constructor(props){
    super(props);
    this.state={isListOpen: false}
  };

  render () {
    return (
      <React.Fragment>
        <div className="category-btn">
          <p>{this.props.name}</p>
        </div>
      </React.Fragment>
    );
  }
}

export default Category;
