#include"pupilDetect.h"
#include <math.h>

//Mat obj is the pupil template to match over the eye image
//pupilCenter is the detected pupil center

int biPupilDetect(cv::Mat eyeL,
                cv::Rect roiL,
                cv::Point pupilCenterL,
                cv::Mat eyeR ,
                cv::Rect roiR,
                cv::Point pupilCenterR,
                cv::Mat obj,
                float &objScale)
{
    int method = cv::TemplateMatchModes::TM_CCOEFF_NORMED;
    int matchResultWidthL,matchResultHeightL,
            matchResultWidthR,matchResultHeightR;


    //if the roi rectangle is not valid ,return
    if (roiL.width==0||roiL.height==0||roiR.width==0||roiR.height==0)
        return -1;


    cv::Mat roiImgL(eyeL,roiL);
    cv::Mat roiImgR(eyeR,roiR);

    cv::Mat matchResultL,matchResultR,scaledObj;

    double sizeRatioRefROI=0.4;


    //scale the obj template to the /proper size in the ROI image of eye image
    if(objScale==0)
        objScale=0.9;

    cv::resize(obj,scaledObj,
               cv::Size(round(objScale*obj.size().width),round(objScale*obj.size().height)),
               0,0,cv:: INTER_LINEAR);


    while ((scaledObj.size().width>sizeRatioRefROI*roiImgR.cols)||(scaledObj.size().width>sizeRatioRefROI*roiImgL.cols)||\
           (scaledObj.size().height>sizeRatioRefROI*roiImgL.rows)||(scaledObj.size().height>sizeRatioRefROI*roiImgR.rows))
    {
        objScale = objScale*0.9;
        cv::resize(obj,scaledObj,
                   cv::Size(round(objScale*obj.size().width),round(objScale*obj.size().height)),
                   0,0,cv:: INTER_LINEAR);
    }

    scaledObj.convertTo(scaledObj , obj.type() , 1 , 0 );
    cv::namedWindow("scaledObj");
    // cv::imshow("scaledObj", scaledObj);


    //match the template over the ROI image ,store the match result in the the Mat matchResultL & matchResultR
    matchResultWidthL = roiImgL.cols - scaledObj.size().width + 1;
    matchResultHeightL = roiImgL.rows - scaledObj.size().height + 1;

    matchResultWidthR = roiImgR.cols - scaledObj.size().width + 1;
    matchResultHeightR = roiImgR.rows - scaledObj.size().height + 1;

    matchResultL.create(matchResultWidthL,matchResultHeightL,CV_32FC1);
    matchResultR.create(matchResultWidthR,matchResultHeightR,CV_32FC1);

    cv::matchTemplate(eyeL,scaledObj,matchResultL,method);
    cv::matchTemplate(eyeR,scaledObj,matchResultR,method);


    //find out the position of the most matching patch
    double minValL, maxValL,minValR, maxValR;
    cv::Point minLoc_L, maxLoc_L,minLoc_R, maxLoc_R;
    cv::minMaxLoc(matchResultL, &minValL, &maxValL, &minLoc_L, &maxLoc_L);
    cv::minMaxLoc(matchResultR, &minValR, &maxValR, &minLoc_R, &maxLoc_R);


    //show the matched patch
    // cv::rectangle(roiImgL, cv::Point(maxLoc_L.x,maxLoc_L.y),
    //              cv::Point(maxLoc_L.x + scaledObj.size().width,
    //                         maxLoc_L.y + scaledObj.size().height),cv::Scalar(0,0,255), 2, 8, 0);
    // cv::namedWindow("roiImgL");
    // cv::imshow("roiImgL", roiImgL);

    // cv::rectangle(roiImgR, cv::Point(maxLoc_R.x,maxLoc_R.y),
    //               cv::Point(maxLoc_R.x + scaledObj.size().width,
    //                         maxLoc_R.y + scaledObj.size().height),cv::Scalar(0,0,255), 2, 8, 0);
    // cv::namedWindow("roiImgR");
    // cv::imshow("roiImgR", roiImgR);



}


int monoPupilDetect(const cv::Mat&  eye,
                const cv::Rect& roi,
                cv::Point& pupilCenter,
                const cv::Mat& obj,
                float objScale)
{

    int method = cv::TemplateMatchModes::TM_CCOEFF_NORMED;
    int matchResultWidth,matchResultHeight;

    //if the roi rectangle is not valid ,return
    if (roi.width==0||roi.height==0)
        return -1;

    if(0==objScale)
        return -1;


    cv::Mat tmpMat = cv::Mat::zeros(eye.size(), CV_8U);
    cv::cvtColor(eye, tmpMat, CV_RGB2GRAY);

    cv::Mat roiImg(tmpMat, roi);
    cv::Mat matchResult,scaledObj;



    //scale the obj template to the proper size in the ROI image of eye image
    double sizeRatioRefROI=0.4 * objScale;
    double minRarioOfRoiAndObj =
            sizeRatioRefROI *
            std::min(float(roi.width) / obj.cols,
                     float(roi.height) / obj.rows);
    cv::resize(obj, scaledObj,cv::Size(obj.size().width*minRarioOfRoiAndObj,obj.size().height*minRarioOfRoiAndObj));

    scaledObj.convertTo(scaledObj , obj.type() , 1 , 0 );

    // cv::namedWindow("scaledObj");
    // cv::imshow("scaledObj", scaledObj);


    //match the template over the ROI image ,store the match result in the the Mat matchResultL & matchResultR
    matchResultWidth = roiImg.cols - scaledObj.size().width + 1;
    matchResultHeight = roiImg.rows - scaledObj.size().height + 1;

    //matchResult.create(matchResultWidth,matchResultHeight,CV_32FC1);

    cv::matchTemplate(roiImg, scaledObj,matchResult, method);

    //find out the position of the most matching patch
    double minVal, maxVal;
    cv::Point minLoc, maxLoc;
    cv::minMaxLoc(matchResult, &minVal, &maxVal, &minLoc, &maxLoc);
    pupilCenter = maxLoc + cv::Point(scaledObj.cols / 2, scaledObj.rows / 2) + cv::Point(roi.x, roi.y);

//     show the matched patch
    // cv::rectangle(roiImg, cv::Point(maxLoc.x,maxLoc.y),
      //             cv::Point(maxLoc.x + scaledObj.size().width,
      //                       maxLoc.y + scaledObj.size().height),cv::Scalar(0,0,255), 2, 8, 0);
     //cv::namedWindow("roiImg");
     //cv::imshow("roiImg", roiImg);
     //cv::waitKey(1);
}
