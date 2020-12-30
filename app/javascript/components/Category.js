import React from "react"
class Category extends React.Component {

  constructor(props){
    super(props);
    this.state={isListOpen: false}
  };

  handleMouseOver(){
    this.setState({isListOpen: true});
  }

  handleMouseOut(){
    this.setState({isListOpen: false});
  }


  render () {
    let list;
    if (this.state.isListOpen){
      list = (
        <p>{this.props.name}</p>
      );
    }
    return (
      <React.Fragment>
        <p 
          onMouseOver={() => {this.handleMouseOver()}}
          onMouseOut={() => {this.handleMouseOut()}}
        >
            OK
          </p>
        {list}
      </React.Fragment>
    );
  }
}

export default Category;
