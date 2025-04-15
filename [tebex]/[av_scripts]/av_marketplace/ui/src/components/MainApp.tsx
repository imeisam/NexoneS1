import { useState, useEffect } from "react";
import { Box } from "@mantine/core";
import { ModalMenu } from "./ModalMenu/ModalMenu";
import { fetchNui, isEnvBrowser, useNuiEvent } from "../hooks/useNuiEvents";
import { useRecoilValue, useSetRecoilState } from "recoil";
import { identifier, isAdmin, Lang } from "../reducers/atoms";
import { Loading } from "./Loading";
import classes from "./appStyle.module.css";
import { Header } from "./Header/Header";
import { Content } from "./Content/Content";
import { Product } from "../types/types";

export const MainApp = () => {
  const lang: any = useRecoilValue(Lang);
  const setIsAdmin = useSetRecoilState(isAdmin);
  const setIdentifier = useSetRecoilState(identifier);
  const [loaded, setLoaded] = useState(isEnvBrowser());
  const [canCreate, setCanCreate] = useState(true);
  const [allowedCategories, setAllowedCategories] = useState([]);
  const [categories, setCategories] = useState([]);
  const [category, setCategory] = useState("");
  const [allItems, setAllItems] = useState<Product[]>([]);
  const [filtered, setFiltered] = useState<Product[]>([]);
  const [showModal, setShowModal] = useState(false);
  const [modalOptions, setModalOptions] = useState({});
  useNuiEvent("newAd", (data: Product) => {
    const copy = [...allItems, data];
    setAllItems(copy);
    setFiltered(copy);
  });
  const handleDelete = (identifier: string) => {
    const copy = allItems.filter((item) => item.identifier !== identifier);
    setAllItems(copy);
    setFiltered(copy);
    fetchNui("av_marketplace", "deleteAd", identifier);
  };
  const handleCategory = async (option: string | null) => {
    if (!option) return;
    const resp = await fetchNui("av_marketplace", "getItems", option);
    if (resp) {
      setAllItems(resp);
      setFiltered(resp);
      setCategory(option);
    } else {
      setAllItems([]);
      setFiltered([]);
      setCategory(option);
    }
  };
  const handleSearch = (value: string) => {
    if (value == "") {
      setFiltered(allItems);
      return;
    }
    const query = value.toLowerCase();
    const copy = allItems.filter((ad) =>
      ad.title.toLowerCase().includes(query)
    );
    setFiltered(copy);
  };
  const handleAd = () => {
    setModalOptions({
      title: lang.title,
      options: [
        {
          name: "title",
          type: "text",
          title: lang.adTitle,
          max: 30,
          asterisk: true,
        },
        {
          name: "category",
          type: "select",
          title: lang.category,
          options: allowedCategories,
          asterisk: true,
        },
        { name: "image", type: "text", title: lang.image, asterisk: true },
        {
          name: "price",
          type: "number",
          title: lang.price,
          asterisk: true,
        },
        {
          name: "phone",
          type: "number",
          title: lang.phone,
          asterisk: true,
        },
        {
          name: "expires",
          type: "select",
          title: lang.expires,
          options: [
            { value: "1", label: lang["1day"] },
            { value: "3", label: lang["3day"] },
            { value: "5", label: lang["5day"] },
            { value: "7", label: lang["7day"] },
          ],
          asterisk: true,
        },
        {
          name: "description",
          type: "textarea",
          title: lang.description,
          max: 100,
        },
      ],
      button: lang.button,
      callback: handleCallback,
    });
    setShowModal(true);
  };
  useEffect(() => {
    const fetchData = async () => {
      const resp = await fetchNui("av_marketplace", "getData");
      if (resp) {
        setCategories(resp.allCategories);
        setAllowedCategories(resp.allowedCategories);
        setIsAdmin(resp.isAdmin);
        setIdentifier(resp.identifier);
        setCanCreate(resp.canCreate);
        handleCategory(resp.allCategories[0]?.value);
      }
      setTimeout(() => {
        setLoaded(true);
      }, 100);
    };
    fetchData();
  }, []);

  const handleCallback = (data: any) => {
    setShowModal(false);
    if (!data) return;
    const copy = { ...data, currentCategory: category };
    fetchNui("av_marketplace", "createAd", copy);
  };
  if (!loaded) return <Loading />;
  return (
    <Box className={classes.app}>
      {showModal && <ModalMenu data={modalOptions} />}
      <Box className={classes.container}>
        <Header
          categories={categories}
          category={category}
          handleCategory={handleCategory}
          handleSearch={handleSearch}
          handleAd={handleAd}
          canCreate={canCreate}
        />
        <Content items={filtered} handleDelete={handleDelete} />
      </Box>
    </Box>
  );
};
