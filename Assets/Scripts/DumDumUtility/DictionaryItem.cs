using UnityEngine;

namespace RTSGame
{
    // a class solely because Unity is still a half baked potato and doesn't serialize Dictionaries
    [System.Serializable]
    public class DictionaryItem<T, S>
    {
        [SerializeField]
        public T key;
        [SerializeField]
        public S value;
        public DictionaryItem()
        {

        }
        public DictionaryItem(T k, S v)
        {
            key = k;
            value = v;
        }
        public DictionaryItem(DictionaryItem<T, S> item)
        {
            key = item.key;
            value = item.value;
        }


    }
    [System.Serializable]
    public class ResourceDictionaryItem : DictionaryItem<ResourceTypes, int>
    {
        public ResourceDictionaryItem(ResourceDictionaryItem item) : base(item)
        {

        }

    }

    [System.Serializable]
    public class ActionDictionaryItem : DictionaryItem<ActionType, Sprite>
    {
        public ActionDictionaryItem(ActionDictionaryItem item) : base(item)
        {

        }
    }

    [System.Serializable]
    public class UnitTypeDictionaryItem : DictionaryItem<UnitType, int>
    {
        public UnitTypeDictionaryItem(UnitTypeDictionaryItem item) : base(item)
        { }
         public UnitTypeDictionaryItem(UnitType k, int v) : base(k, v)
        {

        }
        
    }


}
