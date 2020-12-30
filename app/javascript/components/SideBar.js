import React from "react"
import PropTypes from "prop-types"
import Category from "./Category"
class SideBar extends React.Component {
  render () {
    const categoryList = [
      {name: '滅菌'},
      {name: '洗浄'},
      {name: '包装'},
      {name: '乾燥'},
      {name: '組立'},
      {name: '保管'},
      {name: 'その他'},
    ];
      return (
        <React.Fragment>
          <p>カテゴリー</p>
          {categoryList.map((categoryItem) => {
            return (
              <Category
                name={categoryItem.name}
              />
            );
          })}
        </React.Fragment>
      );
  }
}


export default SideBar
