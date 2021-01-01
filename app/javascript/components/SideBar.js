import React from "react"
import PropTypes from "prop-types"
import Category from "./Category"
class SideBar extends React.Component {
  render () {
      return (
        <React.Fragment>
          <Category name1="滅菌"
                    name2="洗浄"
                    name3="包装"
                    name4="乾燥"
                    name5="組立"
                    name6="保管"
                    name7="その他"
        />
        </React.Fragment>
      );
  }
}


export default SideBar
